import 'package:equatable/equatable.dart';

/// Defines authentication-related events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check if the current session is valid.
class CheckSession extends AuthEvent {
  const CheckSession();
}

/// Event to log the user out and clear the session.
class LogoutButtonPressed extends AuthEvent {
  const LogoutButtonPressed();
}
