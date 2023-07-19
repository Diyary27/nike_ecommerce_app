part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.isLoginMode);

  final bool isLoginMode;

  @override
  List<Object> get props => [isLoginMode];
}

class AuthInitial extends AuthState {
  AuthInitial(super.isLoginMode);
}

class AuthLoading extends AuthState {
  AuthLoading(super.isLoginMode);
}

class AuthSuccess extends AuthState {
  AuthSuccess(super.isLoginMode);
}

class AuthError extends AuthState {
  final AppException exception;
  AuthError(super.isLoginMode, this.exception);
}
