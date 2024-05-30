import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/domain/usecases/get_user.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUserUseCase getUserUseCase;

  GetUserBloc({required this.getUserUseCase}) : super(GetUserInitial()) {
    on<FetchUser>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    try {
      // Execute the use case and handle success/failure
      final result = await getUserUseCase();
      if (result is DataSuccess<UserEntity>) {
        emit(GetUserLoaded(result.data!));
      } else if (result is DataFailed<UserEntity>) {
        emit(GetUserFailure(
            result.error?.toString() ?? 'An unknown error occurred'));
      }
      print(result.data);
    } catch (error) {
      // Check if the error is an OperationException
      if (error is OperationException) {
        emit(GetUserFailure(error.toString()));
      } else {
        // Handle other types of exceptions
        emit(GetUserFailure(
            'An unexpected error occurred: ${error.toString()}'));
      }
    }
  }
}
