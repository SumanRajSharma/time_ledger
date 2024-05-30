import 'package:equatable/equatable.dart';

class CreateUserEntity extends Equatable {
  final String id;
  final String email;

  const CreateUserEntity({
    required this.id,
    required this.email,
  });
  @override
  List<Object?> get props {
    return [id, email];
  }
}
