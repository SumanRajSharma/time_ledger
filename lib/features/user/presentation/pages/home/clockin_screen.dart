import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_state.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_state.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/home_content.dart';
import 'package:time_ledger/injection_container.dart';

class ClockInPage extends StatefulWidget {
  const ClockInPage({super.key});

  @override
  State<ClockInPage> createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {
  bool _isClockedIn = false;
  DateTime? _clockInTime;
  DateTime? _clockOutTime;
  Duration? _totalWorkDuration;

  @override
  Widget build(BuildContext context) {
    final manageAuth = sl<ManageAuthentication>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(const CheckSession()),
        ),
        BlocProvider<GetUserBloc>(
          create: (context) => sl<GetUserBloc>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                BlocProvider.of<GetUserBloc>(context).add(const FetchUser());
              } else if (state is Unauthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session expired. Please log in again.'),
                  ),
                );
                manageAuth.logout();
              }
            },
            builder: (context, authState) {
              if (authState is Authenticated) {
                return BlocBuilder<GetUserBloc, GetUserState>(
                  builder: (context, state) {
                    if (state is GetUserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetUserLoaded) {
                      return HomeContent(
                        user: state.user,
                        isClockedIn: _isClockedIn,
                        clockInTime: _clockInTime,
                        clockOutTime: _clockOutTime,
                        totalWorkDuration: _totalWorkDuration,
                        onClockButtonPressed: _onClockButtonPressed,
                      );
                    } else if (state is GetUserFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else {
                      return const Center(child: Text('No user data found.'));
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text('Please log in to see your profile information.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _onClockButtonPressed() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isClockedIn = !_isClockedIn;
      if (_isClockedIn) {
        _clockInTime = DateTime.now();
      } else {
        _clockOutTime = DateTime.now();
        if (_clockInTime != null) {
          _totalWorkDuration = _clockOutTime!.difference(_clockInTime!);
        }
      }
    });
  }
}
