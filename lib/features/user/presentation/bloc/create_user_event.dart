import 'package:equatable/equatable.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends CreateUserEvent {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;

  const RegisterButtonPressed(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.phoneNumber});

  @override
  List<Object?> get props => [fullName, email, password, phoneNumber];
}
