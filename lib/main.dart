import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:time_ledger/config/theme/app_text_themes.dart';
import 'package:time_ledger/core/navigation/app_router_delegate.dart';
import 'package:time_ledger/core/navigation/app_state.dart';
import 'package:time_ledger/core/navigation/page_information_parser.dart';
import 'package:time_ledger/features/auth/domain/usecases/check_token_validity.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_state.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection
    final appState = di.sl<AppState>();
    final manageAuth = di.sl<ManageAuthentication>();
    final routerDelegate = AppRouterDelegate(manageAuth, appState);
    final routeParser = PageInformationParser();
    TextTheme textTheme = createTextTheme(context, 'Urbanist', 'Urbanist');
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
        BlocProvider<ThemeBloc>(
          create: (context) => di.sl<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final lightColorScheme = ColorScheme.fromSeed(
            seedColor: themeState.seedColor,
          );

          final darkColorScheme = ColorScheme.fromSeed(
            seedColor: themeState.seedColor,
            brightness: Brightness.dark,
          );

          return GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (dynamic progress) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.5,
                  sigmaY: 4.5,
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitPouringHourGlass(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 14),
                        if (progress != null)
                          Text(
                            progress,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: MaterialApp.router(
              title: 'Time Ledger',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  scaffoldBackgroundColor: lightColorScheme.surface,
                  textTheme: textTheme),
              darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: darkColorScheme,
                  scaffoldBackgroundColor: darkColorScheme.surface,
                  textTheme: textTheme),
              themeMode: themeState.themeMode,
              routerDelegate: routerDelegate,
              routeInformationParser: routeParser,
            ),
          );
        },
      ),
    );
  }
}
