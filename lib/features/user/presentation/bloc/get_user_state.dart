import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object?> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final UserEntity user;

  const GetUserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class GetUserFailure extends GetUserState {
  final String error;

  const GetUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}
