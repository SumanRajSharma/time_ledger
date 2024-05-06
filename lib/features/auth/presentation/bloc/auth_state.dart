import 'package:equatable/equatable.dart';

/// Defines the various authentication states.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app launches.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when the session is valid.
class Authenticated extends AuthState {
  const Authenticated();
}

/// State when the session is invalid.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// State when session validation is in progress.
class CheckingSession extends AuthState {
  const CheckingSession();
}

/// State for representing authentication errors.
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
