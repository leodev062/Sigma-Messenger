import 'package:flutter/material.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/domain/repositories/i_auth_repository.dart';
import 'package:sigma/domain/interactors/auth/request_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/verify_code_interactor.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/data/services/incoming_message_processor.dart';
import 'package:sigma/app/locator.dart';

enum AuthStatus { idle, loading, unauthenticated, success, verified, error }

class AuthState {
  final AuthStatus status;
  final bool initialized;
  final String? error;

  AuthState({
    this.status = AuthStatus.idle,
    this.initialized = false,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? initialized,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      initialized: initialized ?? this.initialized,
      error: error ?? this.error,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  static const String TAG = "AuthViewModel";

  final RequestCodeInteractor _requestCodeInteractor;
  final VerifyCodeInteractor _verifyCodeInteractor;
  final IAuthRepository _authRepository;
  final SocketManager _socketManager;

  AuthState _state = AuthState();
  AuthState get state => _state;

  bool get isLoading => _state.status == AuthStatus.loading;

  AuthViewModel(
    this._requestCodeInteractor,
    this._verifyCodeInteractor,
    this._authRepository,
    this._socketManager,
  ) {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _state = _state.copyWith(status: AuthStatus.verified, initialized: true);
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
    _socketManager.connect(userId);
    // Inicializa o processador de mensagens recebidas (Signal-Style)
    locator<IncomingMessageProcessor>().init();
  }

  Future<void> requestCode(String phone) async {
    _updateState(status: AuthStatus.loading);
    try {
      await _requestCodeInteractor.execute(phone);
      SigmaLog.i(TAG, "Código solicitado com sucesso para $phone");
      _updateState(status: AuthStatus.success);
    } catch (e) {
      SigmaLog.e(TAG, "Erro ao solicitar código", e);
      _updateState(status: AuthStatus.error, error: e.toString());
      rethrow;
    }
  }

  void verifyCode(String phone, String code) async {
    _updateState(status: AuthStatus.loading);
    try {
      final user = await _verifyCodeInteractor.execute(phone, code);
      if (user != null) {
        SigmaLog.i(TAG, "Login realizado com sucesso: ${user.id}");
        _state = _state.copyWith(status: AuthStatus.verified);
        _onLoginSuccess(user.id);
      } else {
        _updateState(status: AuthStatus.error, error: "Usuário nulo após verificação");
      }
    } catch (e) {
      SigmaLog.e(TAG, "Erro na verificação", e);
      _updateState(status: AuthStatus.error, error: e.toString());
      rethrow;
    } finally {
      notifyListeners();
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
