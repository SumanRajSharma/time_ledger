import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/navigation/app_state.dart';
import 'package:time_ledger/features/clients/domain/usecases/create_client.dart';
import 'package:time_ledger/features/clients/domain/usecases/get_client.dart';
import 'package:time_ledger/service/graphql_service.dart';
import 'package:time_ledger/service/token_service.dart';

// Auth Feature
import 'package:time_ledger/features/auth/data/repository/logout_repository_impl.dart';
import 'package:time_ledger/features/auth/data/repository/login_repository_impl.dart';
import 'package:time_ledger/features/auth/data/repository/token_repository_impl.dart';
import 'package:time_ledger/features/auth/domain/repository/logout_repository.dart';
import 'package:time_ledger/features/auth/domain/repository/login_repository.dart';
import 'package:time_ledger/features/auth/domain/repository/token_repository.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/domain/usecases/get_login_token.dart';
import 'package:time_ledger/features/auth/domain/usecases/logout_user.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_bloc.dart';

// User Feature
import 'package:time_ledger/features/user/data/repository/create_user_repository_impl.dart';
import 'package:time_ledger/features/user/data/repository/get_user_repository_impl.dart';
import 'package:time_ledger/features/user/domain/repository/create_user_repository.dart';
import 'package:time_ledger/features/user/domain/repository/get_user_repository.dart';
import 'package:time_ledger/features/user/domain/usecases/create_user.dart';
import 'package:time_ledger/features/user/domain/usecases/get_user.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_bloc.dart';

// Clients Feature
import 'package:time_ledger/features/clients/data/repository/get_client_repository_impl.dart';
import 'package:time_ledger/features/clients/data/repository/create_client_repository_impl.dart';
import 'package:time_ledger/features/clients/domain/repository/get_client_repository.dart';
import 'package:time_ledger/features/clients/domain/repository/create_client_repository.dart';
import 'package:time_ledger/features/clients/presentation/bloc/get_clients_bloc.dart';
import 'package:time_ledger/features/clients/presentation/bloc/search_client_bloc.dart';
import 'package:time_ledger/features/clients/presentation/bloc/create_client_bloc.dart';

// Common
import 'package:time_ledger/features/user/presentation/bloc/theme_bloc.dart';

final GetIt sl = GetIt.instance; // sl stands for Service Locator

void init() {
  // Application state
  sl.registerLazySingleton(() => AppState());

  // Services
  sl.registerLazySingleton<SecureTokenService>(() => SecureTokenService());

  // GraphQL Client
  sl.registerLazySingleton<GraphQLClient>(
    () => GraphQLService.initializeClient(),
  );

  // Auth Feature
  _initAuth();

  // User Feature
  _initUser();

  // Clients Feature
  _initClients();

  // Common
  _initCommon();
}

void _initAuth() {
  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );
  sl.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );
  sl.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(tokenService: sl<SecureTokenService>()),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetLoginTokenUseCase(sl<LoginRepository>()),
  );
  sl.registerLazySingleton(
    () => CheckTokenValidityUseCase(tokenRepository: sl<TokenRepository>()),
  );
  sl.registerLazySingleton(
    () => LogoutUserUseCase(sl<LogoutRepository>()),
  );
  sl.registerLazySingleton(
    () => ManageAuthentication(sl<AppState>(), sl<SecureTokenService>()),
  );

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      checkTokenValidityUseCase: sl<CheckTokenValidityUseCase>(),
      logoutUserUseCase: sl<LogoutUserUseCase>(),
    ),
  );
  sl.registerFactory(
    () => LoginBloc(sl<GetLoginTokenUseCase>(), sl<AuthBloc>()),
  );
}

void _initUser() {
  // Repositories
  sl.registerLazySingleton<CreateUserRepository>(
    () => CreateUserRepositoryImpl(graphQLClient: sl<GraphQLClient>()),
  );
  sl.registerLazySingleton<GetUserRepository>(
    () => GetUserRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => CreateUserUseCase(sl<CreateUserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetUserUseCase(sl<GetUserRepository>()),
  );

  // BLoCs
  sl.registerFactory(
    () => CreateUserBloc(sl<CreateUserUseCase>()),
  );
  sl.registerFactory(
    () => GetUserBloc(getUserUseCase: sl<GetUserUseCase>()),
  );
}

void _initClients() {
  // Repositories
  sl.registerLazySingleton<GetClientRepository>(
    () => GetClientRepositoryImpl(
      tokenService: sl<SecureTokenService>(),
      graphQLClient: sl<GraphQLClient>(),
    ),
  );
  sl.registerLazySingleton<CreateClientRepository>(
    () => CreateClientRepositoryImpl(
      graphQLClient: sl<GraphQLClient>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetClientUseCase(sl<GetClientRepository>()),
  );
  sl.registerLazySingleton(
    () => CreateClientUseCase(sl<CreateClientRepository>()),
  );

  // BLoCs
  sl.registerFactory(
    () => GetClientsBloc(getClientUseCase: sl<GetClientUseCase>()),
  );
  sl.registerFactory<SearchClientBloc>(() => SearchClientBloc());
  sl.registerFactory(
    () => CreateClientBloc(sl<CreateClientUseCase>()),
  );
}

void _initCommon() {
  sl.registerLazySingleton(() => ThemeBloc());
}
