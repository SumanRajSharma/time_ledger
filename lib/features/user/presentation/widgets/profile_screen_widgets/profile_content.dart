import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:time_ledger/features/clients/presentation/pages/clients_screen.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/profile_screen.dart';
import 'package:time_ledger/features/user/presentation/widgets/profile_screen_widgets/logout_button.dart';
import 'package:time_ledger/features/user/presentation/widgets/profile_screen_widgets/menu_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/profile_screen_widgets/profile_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/profile_screen_widgets/theme_card.dart';

class ProfileContent extends StatelessWidget {
  final UserEntity user;
  final ThemeOptions themeOption;
  final ValueChanged<ThemeOptions> onThemeChanged;
  final VoidCallback onLogoutButtonPressed;

  const ProfileContent({
    super.key,
    required this.user,
    required this.themeOption,
    required this.onThemeChanged,
    required this.onLogoutButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 80,
                  ), // To make space for the button
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ProfileCard(user: user),
                      ThemeCard(
                        themeOption: themeOption,
                        onThemeChanged: onThemeChanged,
                      ),
                      MenuCard(
                        title: 'Clients',
                        icon: Iconsax.profile_2user5,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientsScreen()));
                        },
                      ),
                      MenuCard(
                        title: 'Help & FAQs',
                        icon: Iconsax.message_question5,
                        onTap: () {
                          // Handle FAQs action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: LogoutButton(
              title: 'Logout',
              icon: Iconsax.logout,
              onTap: onLogoutButtonPressed,
            ),
          ),
        ],
      ),
    );
  }
}
