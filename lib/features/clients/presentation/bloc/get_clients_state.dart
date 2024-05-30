import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class GetClientsState extends Equatable {
  const GetClientsState();

  @override
  List<Object?> get props => [];
}

class GetClientsInitial extends GetClientsState {}

class GetClientsLoading extends GetClientsState {}

class GetClientsLoaded extends GetClientsState {
  final List<ClientEntity> clients;

  const GetClientsLoaded(this.clients);

  @override
  List<Object?> get props => [clients];
}

class GetClientsError extends GetClientsState {
  final String message;

  const GetClientsError(this.message);

  @override
  List<Object?> get props => [message];
}
