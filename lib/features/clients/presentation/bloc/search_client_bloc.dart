import 'package:bloc/bloc.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_event.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_state.dart';

class SearchClientBloc extends Bloc<SearchClientEvent, SearchClientState> {
  late List<ClientEntity> allClients;

  SearchClientBloc() : super(SearchClientInitial()) {
    on<InitializeSearch>(_onInitializeSearch);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  void _onInitializeSearch(
      InitializeSearch event, Emitter<SearchClientState> emit) {
    if (state is SearchClientInitial) {
      allClients = event.clients;
      emit(SearchClientLoaded(filteredClients: allClients));
    }
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchClientState> emit) {
    if (state is SearchClientLoaded) {
      final filteredClients = allClients
          .where((client) =>
              client.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(SearchClientLoaded(filteredClients: filteredClients));
    }
  }
}
