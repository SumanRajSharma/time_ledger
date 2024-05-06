import 'package:flutter/material.dart';
import 'package:time_ledger/core/navigation/app_router_delegate.dart';
import 'package:time_ledger/core/navigation/app_state.dart';
import 'package:time_ledger/core/navigation/page_information_parser.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_event.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/config/theme/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = di.sl<AppState>();
    final manageAuth = di.sl<ManageAuthentication>();
    final routerDelegate = AppRouterDelegate(manageAuth, appState);
    final routeParser = PageInformationParser();

    // Check the session status on app start
    manageAuth.checkSession();

    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashNavigationBloc>(
          create: (context) => SplashNavigationBloc(
            checkTokenValidityUseCase: di.sl<CheckTokenValidityUseCase>(),
          )..add(const DetermineInitialPage()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(const CheckSession()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Time Ledger',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        routerDelegate: routerDelegate,
        routeInformationParser: routeParser,
      ),
    );
  }
}
