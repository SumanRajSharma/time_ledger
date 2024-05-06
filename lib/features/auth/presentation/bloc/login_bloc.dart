import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/domain/entities/login.dart';
import 'package:time_ledger/features/auth/domain/usecases/get_login_token.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoginTokenUseCase getLoginTokenUseCase;

  LoginBloc(this.getLoginTokenUseCase) : super(const LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    try {
      final DataState<LoginEntity> result = await getLoginTokenUseCase
          .call(params: {'email': event.email, 'password': event.password});

      if (result is DataSuccess<LoginEntity>) {
        emit(LoginSuccess(result.data!));
      } else if (result is DataFailed<LoginEntity>) {
        emit(LoginFailure(
            result.error?.toString() ?? 'An unknown error occurred'));
      }
    } catch (error) {
      // Check if the error is an OperationException
      if (error is OperationException) {
        emit(LoginFailure(error.toString()));
      } else {
        // Handle other types of exceptions
        emit(LoginFailure('An unexpected error occurred: ${error.toString()}'));
      }
    }
  }
}
