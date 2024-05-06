import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/noparam.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Manages authentication state globally.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckTokenValidityUseCase checkTokenValidityUseCase;
  final LogoutUserUseCase logoutUserUseCase;

  AuthBloc({
    required this.checkTokenValidityUseCase,
    required this.logoutUserUseCase,
  }) : super(const AuthInitial()) {
    on<CheckSession>(_onCheckSession);
    on<LogoutButtonPressed>(_onLogout);
  }

  /// Handles the session-checking event.
  Future<void> _onCheckSession(
      CheckSession event, Emitter<AuthState> emit) async {
    emit(const CheckingSession());
    final result = await checkTokenValidityUseCase.call(params: NoParams());
    if (result is DataSuccess && result.data == true) {
      emit(const Authenticated());
    } else {
      emit(const Unauthenticated());
    }
  }

  /// Handles the logout event.
  Future<void> _onLogout(
      LogoutButtonPressed event, Emitter<AuthState> emit) async {
    final result = await logoutUserUseCase.call(params: NoParams());
    if (result is DataSuccess) {
      emit(const Unauthenticated());
    } else {
      emit(const AuthError('Failed to log out'));
    }
  }
}
