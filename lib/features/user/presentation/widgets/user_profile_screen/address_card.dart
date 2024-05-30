import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/address_helper.dart';

class AddressCard extends StatelessWidget {
  final Address parsedAddress;

  const AddressCard({
    super.key,
    required this.parsedAddress,
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
              title: const Text('Street Address'),
              subtitle: Text(
                  '${parsedAddress.streetNumber} ${parsedAddress.streetName}'),
              leading: Icon(
                Iconsax.location5,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(
              height: 2.0,
              thickness: 0.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('City'),
              subtitle: Text(parsedAddress.suburb),
              leading: Icon(
                Iconsax.buildings,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(
              height: 2.0,
              thickness: 0.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('State'),
              subtitle: Text(parsedAddress.state),
              leading: Icon(
                Iconsax.map_15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(
              height: 2.0,
              thickness: 0.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Postal Code'),
              subtitle: Text(parsedAddress.postalCode),
              leading: Icon(
                Icons.mail,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
