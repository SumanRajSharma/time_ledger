import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/core/usecases/noparam.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_state.dart';

// Bloc
class SplashNavigationBloc
    extends Bloc<SplashNavigationEvent, SplashNavigationState> {
  final CheckTokenValidityUseCase checkTokenValidityUseCase;

  SplashNavigationBloc({required this.checkTokenValidityUseCase})
      : super(const SplashInitial()) {
    on<DetermineInitialPage>(_onDetermineInitialPage);
  }

  Future<void> _onDetermineInitialPage(
      DetermineInitialPage event, Emitter<SplashNavigationState> emit) async {
    final result = await checkTokenValidityUseCase.call(params: NoParams());
    if (result is DataSuccess && result.data == true) {
      emit(const NavigateToHome());
    } else {
      emit(const NavigateToLogin());
    }
  }
}
