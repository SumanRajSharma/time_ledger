import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class SearchClientState extends Equatable {
  const SearchClientState();

  @override
  List<Object> get props => [];
}

class SearchClientInitial extends SearchClientState {}

class SearchClientLoaded extends SearchClientState {
  final List<ClientEntity> filteredClients;

  const SearchClientLoaded({required this.filteredClients});

  @override
  List<Object> get props => [filteredClients];
}

class SearchClientError extends SearchClientState {
  final String message;

  const SearchClientError(this.message);

  @override
  List<Object> get props => [message];
}
