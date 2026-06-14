import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_profile/sigma_profile.dart';

enum AuthStatus { idle, loading, unauthenticated, authenticated, verified, error }

class AuthState {
  final AuthStatus status;
  final bool initialized;
  final Recipient? user;
  final String? error;
  /// Phone verified; user must finish [ProfileSetupScreen].
  final bool pendingProfileSetup;
  /// New account: create on profile screen. Returning user: only confirm/edit profile.
  final bool isNewRegistration;
  final String? registrationSessionId;

  AuthState({
    this.status = AuthStatus.idle,
    this.initialized = false,
    this.user,
    this.error,
    this.pendingProfileSetup = false,
    this.isNewRegistration = false,
    this.registrationSessionId,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? initialized,
    Recipient? user,
    String? error,
    bool? pendingProfileSetup,
    bool? isNewRegistration,
    String? registrationSessionId,
    bool clearRegistrationSession = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      initialized: initialized ?? this.initialized,
      user: user ?? this.user,
      error: error ?? this.error,
      pendingProfileSetup: pendingProfileSetup ?? this.pendingProfileSetup,
      isNewRegistration: isNewRegistration ?? this.isNewRegistration,
      registrationSessionId: clearRegistrationSession
          ? null
          : (registrationSessionId ?? this.registrationSessionId),
    );
  }
}

class AuthViewModel extends ChangeNotifier with Loggable {
  final UpdateProfileInteractor _updateProfileInteractor;
  final LoginInteractor _loginInteractor;
  final LogoutInteractor _logoutInteractor;
  final CreateAccountInteractor _createAccountInteractor;
  final IAuthRepository _authRepository;
  final IProfileRepository _profileRepository;

  StreamSubscription<Recipient?>? _userSubscription;

  AuthState _state = AuthState();
  AuthState get state => _state;

  bool get isLoading => _state.status == AuthStatus.loading;

  AuthViewModel({
    required UpdateProfileInteractor updateProfileInteractor,
    required LoginInteractor loginInteractor,
    required LogoutInteractor logoutInteractor,
    required CreateAccountInteractor createAccountInteractor,
    required IAuthRepository authRepository,
    required IProfileRepository profileRepository,
  })  : _updateProfileInteractor = updateProfileInteractor,
        _loginInteractor = loginInteractor,
        _logoutInteractor = logoutInteractor,
        _createAccountInteractor = createAccountInteractor,
        _authRepository = authRepository,
        _profileRepository = profileRepository {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _state = _state.copyWith(status: AuthStatus.verified, user: user, initialized: true);
        
        await _loginInteractor.execute(user.id, isNewLogin: false);
        _listenToUserChanges();
        notifyListeners();

      } else {
        _state = _state.copyWith(status: AuthStatus.unauthenticated, initialized: true);
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.unauthenticated, initialized: true);
      logE("Erro na inicialização: $e");
    }
    notifyListeners();
  }

  void _listenToUserChanges() {
    _userSubscription?.cancel();
    _userSubscription = _profileRepository.watchSelfProfile().listen((user) {
      if (user != null) {
        logD("UI Reativa: Perfil atualizado detectado no banco de dados.");
        _state = _state.copyWith(user: user);
        notifyListeners();
      }
    });
  }

  /// Chamado pela UI quando um usuário existente é verificado.
  Future<void> onVerificationSuccessReturningUser(String userId) async {
    _state = _state.copyWith(
      status: AuthStatus.authenticated,
      pendingProfileSetup: true,
      isNewRegistration: false,
      clearRegistrationSession: true,
    );
    
    await _loginInteractor.execute(userId, isNewLogin: true);
    _listenToUserChanges();
    notifyListeners();
  }

  /// Chamado pela UI quando um novo usuário é verificado.
  Future<void> onVerificationSuccessNewUser({
    required String sessionId,
    required String phone,
  }) async {
    _state = _state.copyWith(
      status: AuthStatus.authenticated,
      user: Recipient(
        id: '',
        type: RecipientType.individual,
        phone: phone,
      ),
      pendingProfileSetup: true,
      isNewRegistration: true,
      registrationSessionId: sessionId,
    );
    notifyListeners();
  }

  Future<void> completeProfileSetup({
    required String name,
    String? username,
    String? avatarUrl,
  }) async {
    _state = _state.copyWith(status: AuthStatus.loading, error: null);
    notifyListeners();

    try {
      if (_state.isNewRegistration) {
        final sessionId = _state.registrationSessionId!;
        final user = await _createAccountInteractor.execute(
          sessionId: sessionId,
          name: name,
          username: username,
          avatarUrl: avatarUrl,
        );
        
        _state = _state.copyWith(
          user: user,
          status: AuthStatus.verified,
          pendingProfileSetup: false,
          isNewRegistration: false,
          clearRegistrationSession: true,
        );
        await _loginInteractor.execute(user.id, isNewLogin: true);
        _listenToUserChanges();
      } else {
        // Detect changes before updating
        final currentUser = _state.user;
        final hasChanges = currentUser?.profileName != name ||
            currentUser?.username != username ||
            currentUser?.avatarUrl != avatarUrl;

        if (hasChanges) {
          logD("Atualizando perfil para usuário existente: $name (@$username)");
          await _updateProfileInteractor.execute(
            name: name,
            username: username,
            bio: _state.user?.bio,
            avatarUrl: avatarUrl ?? _state.user?.avatarUrl,
            isPrivate: _state.user?.isPrivate ?? false,
          );
        }

        _state = _state.copyWith(
          status: AuthStatus.verified,
          pendingProfileSetup: false,
        );
      }
    } catch (e) {
      logE("Erro ao concluir configuração de perfil: $e");
      _state = _state.copyWith(status: AuthStatus.authenticated, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProfile({String? name, String? username, String? bio, String? avatarUrl}) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();
    try {
      await _updateProfileInteractor.execute(
        name: name,
        username: username,
        bio: bio,
        avatarUrl: avatarUrl,
        isPrivate: _state.user?.isPrivate ?? false,
      );
      _state = _state.copyWith(status: AuthStatus.verified);
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    try {
      return await _profileRepository.isUsernameAvailable(username);
    } catch (e) {
      logE("Erro ao verificar username: $e");
      return false;
    }
  }

  Future<void> logout() async {
    _userSubscription?.cancel();
    await _logoutInteractor.execute();
    _state = AuthState(status: AuthStatus.unauthenticated, initialized: true);
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
