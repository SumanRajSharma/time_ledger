import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class CreateClientState extends Equatable {
  const CreateClientState();

  @override
  List<Object> get props => [];
}

class CreateClientInitial extends CreateClientState {
  const CreateClientInitial();
}

class CreateClientLoading extends CreateClientState {
  const CreateClientLoading();
}

class CreateClientSuccess extends CreateClientState {
  final ClientEntity client;

  const CreateClientSuccess(this.client);

  @override
  List<Object> get props => [client];
}

class CreateClientFailure extends CreateClientState {
  final String message;

  const CreateClientFailure(this.message);

  @override
  List<Object> get props => [message];
}
