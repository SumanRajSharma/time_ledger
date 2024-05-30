import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ABNCard extends StatelessWidget {
  final String? abn;

  const ABNCard({
    super.key,
    required this.abn,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('ABN'),
          subtitle: Text(abn ?? 'ABN details not added.'),
          leading: Icon(
            Iconsax.personalcard5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
