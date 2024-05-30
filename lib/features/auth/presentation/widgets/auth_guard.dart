import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_state.dart';
import 'package:time_ledger/features/auth/presentation/pages/login_page.dart';

/// Wrapper widget to handle session validation and redirects.
class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  _AuthGuardState createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  void initState() {
    super.initState();
    // Dispatch CheckSession event at initialization
    BlocProvider.of<AuthBloc>(context).add(const CheckSession());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Redirect to the login page if the session is not valid
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: widget.child,
    );
  }
}
