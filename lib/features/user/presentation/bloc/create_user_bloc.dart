import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/domain/entities/create_user.dart';
import 'package:time_ledger/features/user/domain/usecases/create_user.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateUserUseCase createUserUseCase;

  CreateUserBloc(this.createUserUseCase) : super(const CreateUserInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
      RegisterButtonPressed event, Emitter<CreateUserState> emit) async {
    emit(const CreateUserLoading());
    try {
      final DataState<CreateUserEntity> result =
          await createUserUseCase.call(params: {
        'fullName': event.fullName,
        'email': event.email,
        'password': event.password,
        'phoneNumber': event.phoneNumber
      });

      if (result is DataSuccess<CreateUserEntity>) {
        emit(CreateUserSuccess(result.data!));
      } else if (result is DataFailed<CreateUserEntity>) {
        emit(CreateUserFailure(
            result.error?.toString() ?? 'An unknown error occurred'));
      }
    } catch (error) {
      // Check if the error is an OperationException
      if (error is OperationException) {
        emit(CreateUserFailure(error.toString()));
      } else {
        // Handle other types of exceptions
        emit(CreateUserFailure(
            'An unexpected error occurred: ${error.toString()}'));
      }
    }
  }
}
