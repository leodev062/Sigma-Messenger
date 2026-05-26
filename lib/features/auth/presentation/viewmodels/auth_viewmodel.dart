import 'package:flutter/material.dart';
import 'package:sigma/features/auth/domain/usecases/request_code_usecase.dart';
import 'package:sigma/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:sigma/features/auth/domain/repositories/auth_repository.dart';
import 'package:sigma/core/network/socket_manager.dart';

enum AuthStatus { 
  idle, 
  requestingCode, 
  codeSent, 
  loggingIn, 
  verified,
  success, 
  error, 
  unauthenticated 
}

class AuthState {
  final AuthStatus status;
  final String? phoneNumber;
  final String? errorMessage;
  final String? userId;
  final bool initialized;

  AuthState({
    this.status = AuthStatus.idle,
    this.phoneNumber,
    this.errorMessage,
    this.userId,
    this.initialized = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? phoneNumber,
    String? errorMessage,
    String? userId,
    bool? initialized,
  }) {
    return AuthState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
      initialized: initialized ?? this.initialized,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  final RequestCodeUseCase _requestCodeUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final AuthRepository _authRepository;
  
  final SocketManager _socketManager;

  AuthState _state = AuthState();
  AuthState get state => _state;

  AuthViewModel(
    this._requestCodeUseCase,
    this._verifyCodeUseCase,
    this._authRepository,
    this._socketManager, 
  ) {
    _checkInitialAuth();
  }

  void _checkInitialAuth() async {
    final user = await _authRepository.getCurrentUser();
    
    if (user != null) {
      _state = _state.copyWith(
        status: AuthStatus.success,
        userId: user.id,
        initialized: true,
      );
      _socketManager.connect(user.id);
    } else {
      _state = _state.copyWith(
        status: AuthStatus.unauthenticated,
        initialized: true,
      );
    }
    notifyListeners();
  }

  Future<void> requestCode(String phoneNumber) async {
    _state = _state.copyWith(status: AuthStatus.requestingCode, phoneNumber: phoneNumber);
    notifyListeners();

    try {
      await _requestCodeUseCase.execute(phoneNumber);
      _state = _state.copyWith(status: AuthStatus.codeSent);
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> verifyCode(String smsCode) async {
    if (_state.phoneNumber == null) return;

    _state = _state.copyWith(status: AuthStatus.loggingIn);
    notifyListeners();

    try {
      final user = await _verifyCodeUseCase.execute(
        _state.phoneNumber!,
        smsCode,
      );

      if (user != null) {
        _state = _state.copyWith(status: AuthStatus.verified, userId: user.id);
        _socketManager.connect(user.id);
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetState() {
    _state = AuthState();
    notifyListeners();
  }
}
