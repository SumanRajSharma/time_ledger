import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/domain/usecases/get_client.dart';
import 'get_clients_event.dart';
import 'get_clients_state.dart';

class GetClientsBloc extends Bloc<GetClientsEvent, GetClientsState> {
  final GetClientUseCase getClientUseCase;

  GetClientsBloc({required this.getClientUseCase})
      : super(GetClientsInitial()) {
    on<FetchClients>(_onFetchClients);
  }

  Future<void> _onFetchClients(
    FetchClients event,
    Emitter<GetClientsState> emit,
  ) async {
    emit(GetClientsLoading());
    try {
      final result = await getClientUseCase();
      if (result is DataSuccess<List<ClientEntity>>) {
        emit(GetClientsLoaded(result.data!));
      } else if (result is DataFailed<ClientEntity>) {
        emit(GetClientsError(
            result.error?.toString() ?? 'An unknown error occurred'));
      }
    } catch (error) {
      // Check if the error is an OperationException
      if (error is OperationException) {
        emit(GetClientsError(error.toString()));
      } else {
        // Handle other types of exceptions
        emit(GetClientsError(
            'An unexpected error occurred: ${error.toString()}'));
      }
    }
  }
}
