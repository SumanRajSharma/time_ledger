import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_state.dart';
import 'package:time_ledger/injection_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manageAuth = sl<ManageAuthentication>();
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  manageAuth.logout();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => _onLogoutButtonPressed(context),
                  child: const Text('Logout'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onLogoutButtonPressed(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      const LogoutButtonPressed(),
    );
  }
}
