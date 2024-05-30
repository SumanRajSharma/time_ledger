import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/user/domain/entities/create_user.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object?> get props => [];
}

class CreateUserInitial extends CreateUserState {
  const CreateUserInitial();
}

class CreateUserLoading extends CreateUserState {
  const CreateUserLoading();
}

class CreateUserSuccess extends CreateUserState {
  final CreateUserEntity createUserEntity;

  const CreateUserSuccess(this.createUserEntity);

  @override
  List<Object?> get props => [createUserEntity];
}

class CreateUserFailure extends CreateUserState {
  final String error;

  const CreateUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateUserValidationState extends CreateUserState {
  final String id;
  final String email;

  const CreateUserValidationState(this.id, this.email);

  @override
  List<Object?> get props => [id, email];
}
