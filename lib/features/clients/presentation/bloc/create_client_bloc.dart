import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/domain/usecases/create_client.dart';
import 'package:time_ledger/features/clients/presentation/bloc/create_client_event.dart';
import 'package:time_ledger/features/clients/presentation/bloc/create_client_state.dart';

class CreateClientBloc extends Bloc<CreateClientEvent, CreateClientState> {
  final CreateClientUseCase createClientUseCase;

  CreateClientBloc(this.createClientUseCase)
      : super(const CreateClientInitial()) {
    on<SubmitClient>(_onSubmitClient);
  }

  Future<void> _onSubmitClient(
      SubmitClient event, Emitter<CreateClientState> emit) async {
    emit(const CreateClientLoading());
    try {
      final DataState<ClientEntity> result =
          await createClientUseCase.call(params: {
        'name': event.name,
        'address': event.address,
        'participantName': event.participantName,
        'participantNumber': event.participantNumber,
        'careTypes': event.careTypes,
        'rate': event.rate,
      });

      if (result is DataSuccess<ClientEntity>) {
        emit(CreateClientSuccess(result.data!));
      } else if (result is DataFailed<ClientEntity>) {
        emit(CreateClientFailure(
            result.error?.toString() ?? 'An unknown error occurred'));
      }
    } catch (error) {
      // Check if the error is an OperationException
      if (error is OperationException) {
        emit(CreateClientFailure(error.toString()));
      } else {
        // Handle other types of exceptions
        emit(CreateClientFailure(
            'An unexpected error occurred: ${error.toString()}'));
      }
    }
  }
}
