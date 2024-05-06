import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/navigation/app_state.dart';
import 'package:time_ledger/features/auth/data/repository/logout_repository_impl.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/domain/repository/token_repository.dart';
import 'package:time_ledger/features/auth/data/repository/token_repository_impl.dart';
import 'package:time_ledger/features/auth/domain/repository/login_repository.dart';
import 'package:time_ledger/features/auth/data/repository/login_repository_impl.dart';
import 'package:time_ledger/features/auth/domain/repository/logout_repository.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/domain/usecases/get_login_token.dart';
import 'package:time_ledger/features/auth/domain/usecases/logout_user.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_bloc.dart';
import 'package:time_ledger/service/graphql_service.dart';
import 'package:time_ledger/service/token_service.dart';

final GetIt sl = GetIt.instance; // sl stands for Service Locator

void init() {
  // Application state
  sl.registerLazySingleton(() => AppState());

  // Services
  sl.registerLazySingleton<SecureTokenService>(() => SecureTokenService());

  // Use cases
  sl.registerLazySingleton(
      () => ManageAuthentication(sl<AppState>(), sl<SecureTokenService>()));

  // GraphQL Client
  sl.registerLazySingleton<GraphQLClient>(
      () => GraphQLService.initializeClient());

  // Login Repository and Use Case cases
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetLoginTokenUseCase(
      sl<LoginRepository>(),
    ),
  );

  // Token Repository
  sl.registerLazySingleton<TokenRepository>(
      () => TokenRepositoryImpl(tokenService: sl<SecureTokenService>()));

  // Logout Repository
  sl.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => CheckTokenValidityUseCase(tokenRepository: sl<TokenRepository>()),
  );
  sl.registerLazySingleton(
    () => LogoutUserUseCase(sl<LogoutRepository>()),
  );

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      checkTokenValidityUseCase: sl<CheckTokenValidityUseCase>(),
      logoutUserUseCase: sl<LogoutUserUseCase>(),
    ),
  );
  sl.registerFactory(
    () => LoginBloc(
      sl<GetLoginTokenUseCase>(),
    ),
  );
}
