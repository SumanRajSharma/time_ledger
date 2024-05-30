import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/user_profile_screen.dart';

class ProfileCard extends StatelessWidget {
  final UserEntity user;

  const ProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            user.fullName[0], // Display the first initial of the name
            style: TextStyle(
              fontSize: 50.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        Text(
          user.email,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          user: user,
                        )));
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          child: Text('View Profile',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
