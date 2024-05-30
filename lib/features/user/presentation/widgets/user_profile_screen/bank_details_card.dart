import 'package:flutter/material.dart';

class BankDetailsCard extends StatelessWidget {
  const BankDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Account Name'),
              subtitle: const Text('John Doe'),
              leading: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(
              thickness: 0.5,
              height: 2,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Account Number'),
              subtitle: const Text('123456789'),
              leading: Icon(
                Icons.account_balance,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(
              height: 2.0,
              thickness: 0.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('BSB'),
              subtitle: const Text('123-456'),
              leading: Icon(
                Icons.account_balance_wallet,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
