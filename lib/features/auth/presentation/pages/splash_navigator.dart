import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/splash_navigation_state.dart';
import 'package:time_ledger/features/user/presentation/pages/home/home_screen.dart';
import 'package:time_ledger/features/auth/presentation/pages/login_page.dart';
import 'package:time_ledger/features/auth/presentation/widgets/auth_guard.dart';

class SplashNavigator extends StatelessWidget {
  const SplashNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashNavigationBloc, SplashNavigationState>(
      builder: (context, state) {
        if (state is NavigateToHome) {
          // Protect the home screen with AuthGuard
          return const AuthGuard(child: HomeScreen());
        } else if (state is NavigateToLogin) {
          return LoginPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
