import 'package:equatable/equatable.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';

abstract class SearchClientEvent extends Equatable {
  const SearchClientEvent();

  @override
  List<Object> get props => [];
}

class InitializeSearch extends SearchClientEvent {
  final List<ClientEntity> clients;

  const InitializeSearch(this.clients);

  @override
  List<Object> get props => [clients];
}

class SearchQueryChanged extends SearchClientEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
