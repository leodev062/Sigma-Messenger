import 'package:flutter/material.dart';
import 'package:sigma/domain/services/i_socket_service.dart';
import 'package:sigma/domain/repositories/i_auth_repository.dart';
import 'package:sigma/domain/interactors/auth/request_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/verify_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/update_profile_interactor.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/data/services/incoming_message_processor.dart';
import 'package:sigma/app/locator.dart';
import 'package:sigma/domain/entities/user_entity.dart';

enum AuthStatus { idle, loading, unauthenticated, success, authenticated, verified, error }

class AuthState {
  final AuthStatus status;
  final bool initialized;
  final UserEntity? user;
  final String? error;

  AuthState({
    this.status = AuthStatus.idle,
    this.initialized = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? initialized,
    UserEntity? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      initialized: initialized ?? this.initialized,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  static const String _tag = "AuthViewModel";

  final RequestCodeInteractor _requestCodeInteractor;
  final VerifyCodeInteractor _verifyCodeInteractor;
  final UpdateProfileInteractor _updateProfileInteractor;
  final IAuthRepository _authRepository;
  final ISocketService _socketService;

  AuthState _state = AuthState();
  AuthState get state => _state;

  bool get isLoading => _state.status == AuthStatus.loading;

  AuthViewModel(
    this._requestCodeInteractor,
    this._verifyCodeInteractor,
    this._updateProfileInteractor,
    this._authRepository,
    this._socketService,
  ) {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _state = _state.copyWith(status: AuthStatus.verified, user: user, initialized: true);
        _onLoginSuccess(user.id);
      } else {
        _state = _state.copyWith(status: AuthStatus.unauthenticated, initialized: true);
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.unauthenticated, initialized: true);
    }
    notifyListeners();
  }

  void _onLoginSuccess(String userId) {
    _socketService.connect(userId);
    // Inicializa o processador de mensagens recebidas (Signal-Style)
    locator<IncomingMessageProcessor>().init();
  }

  Future<void> requestCode(String phone) async {
    _updateState(status: AuthStatus.loading);
    try {
      await _requestCodeInteractor.execute(phone);
      SigmaLog.i(_tag, "Código solicitado com sucesso para $phone");
      _updateState(status: AuthStatus.success);
    } catch (e) {
      SigmaLog.e(_tag, "Erro ao solicitar código", e);
      _updateState(status: AuthStatus.error, error: e.toString());
      rethrow;
    }
  }

  void verifyCode(String phone, String code) async {
    _updateState(status: AuthStatus.loading);
    try {
      final user = await _verifyCodeInteractor.execute(phone, code);
      if (user != null) {
        SigmaLog.i(_tag, "Login realizado com sucesso: ${user.id}");
        _state = _state.copyWith(status: AuthStatus.authenticated, user: user);
        _onLoginSuccess(user.id);
      } else {
        _updateState(status: AuthStatus.error, error: "Usuário nulo após verificação");
      }
    } catch (e) {
      SigmaLog.e(_tag, "Erro na verificação", e);
      _updateState(status: AuthStatus.error, error: e.toString());
      // rethrow; // Removido para evitar crash não tratado na UI
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProfile({String? name, String? username, String? bio, String? avatarUrl}) async {
    _updateState(status: AuthStatus.loading);
    try {
      final user = await _updateProfileInteractor.execute(
        name: name,
        username: username,
        bio: bio,
        avatarUrl: avatarUrl,
      );
      _state = _state.copyWith(status: AuthStatus.verified, user: user);
      SigmaLog.i(_tag, "Perfil atualizado com sucesso!");
    } catch (e) {
      SigmaLog.e(_tag, "Erro ao atualizar perfil", e);
      _updateState(status: AuthStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    try {
      return await _authRepository.isUsernameAvailable(username);
    } catch (e) {
      return false;
    }
  }

  void resetState() {
    _state = _state.copyWith(status: AuthStatus.unauthenticated);
    notifyListeners();
  }

  void _updateState({AuthStatus? status, String? error}) {
    _state = _state.copyWith(status: status, error: error);
    notifyListeners();
  }
}
