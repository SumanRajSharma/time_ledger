import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/auth_state.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/get_user_state.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/theme_event.dart';
import 'package:time_ledger/features/user/presentation/widgets/profile_screen_widgets/profile_content.dart';
import 'package:time_ledger/injection_container.dart';

// Enum to keep track of the theme options.
enum ThemeOptions { system, light, dark }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ThemeOptions themeOption = ThemeOptions.system;

  ThemeMode mapThemeOptionsToThemeMode(ThemeOptions themeOption) {
    switch (themeOption) {
      case ThemeOptions.light:
        return ThemeMode.light;
      case ThemeOptions.dark:
        return ThemeMode.dark;
      case ThemeOptions.system:
      default:
        return ThemeMode.system;
    }
  }

  ThemeOptions mapThemeModeToThemeOptions(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return ThemeOptions.light;
      case ThemeMode.dark:
        return ThemeOptions.dark;
      case ThemeMode.system:
      default:
        return ThemeOptions.system;
    }
  }

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
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            BlocProvider.of<GetUserBloc>(context).add(const FetchUser());
          } else if (state is Unauthenticated) {
            context.loaderOverlay.hide();
            manageAuth.logout();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Logout successful. Your session has ended. Come back anytime!'),
              ),
            );
            // Navigate to the login page or perform other logout actions
            manageAuth.logout();
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthLoading) {
            context.loaderOverlay.show(progress: 'Signing Out..');
          }
        },
        builder: (context, authState) {
          if (authState is Authenticated) {
            return BlocBuilder<GetUserBloc, GetUserState>(
              builder: (context, userState) {
                if (userState is GetUserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userState is GetUserLoaded) {
                  return ProfileContent(
                    user: userState.user,
                    themeOption: themeOption,
                    onThemeChanged: (newOption) {
                      setState(() {
                        themeOption = newOption;
                        context.read<ThemeBloc>().add(ThemeChanged(
                            mapThemeOptionsToThemeMode(newOption)));
                      });
                    },
                    onLogoutButtonPressed: () =>
                        _onLogoutButtonPressed(context),
                  );
                } else if (userState is GetUserFailure) {
                  return Center(child: Text('Error: ${userState.error}'));
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
    );
  }

  void _onLogoutButtonPressed(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(const LogoutButtonPressed());
  }
}
