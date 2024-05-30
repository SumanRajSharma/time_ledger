import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';

class GreetingSection extends StatelessWidget {
  final UserEntity user;

  const GreetingSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String firstName = user.fullName.split(' ').first;
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              user.fullName[0],
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hi, $firstName!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
            ],
          ),
        ),
      ],
    );
  }
}
