import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/auth/domain/entities/login.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  const LoginSuccess(this.loginEntity);

  @override
  List<Object?> get props => [loginEntity];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginValidationState extends LoginState {
  final bool isValid;
  final String message;

  const LoginValidationState(this.isValid, this.message);

  @override
  List<Object?> get props => [isValid, message];
}

class LoginNeedsVerification extends LoginState {
  const LoginNeedsVerification();

  @override
  List<Object?> get props => [];
}
