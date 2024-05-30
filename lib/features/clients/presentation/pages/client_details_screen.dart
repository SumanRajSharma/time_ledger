import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/presentation/pages/edit_client_screen.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/section_title.dart';

class ClientDetailsScreen extends StatelessWidget {
  final ClientEntity client;

  const ClientDetailsScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Details'),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                clientHeader(context, client),
                const SizedBox(height: 32),
                const SectionTitle(title: 'Participant Details'),
                const SizedBox(height: 8),
                participantDetails(
                    context, client.participantName, client.participantNumber),
                const SizedBox(height: 32),
                const SectionTitle(title: 'Participant Rates'),
                const SizedBox(height: 8),
                buildRatePill(context, client.rate),
                const SizedBox(height: 32),
                const SectionTitle(title: 'Care Types'),
                const SizedBox(height: 8),
                participantCareTypes(context, client.careTypes),
              ],
            )));
  }
}

Widget clientHeader(BuildContext context, ClientEntity client) {
  return Center(
    child: Column(
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            client.name[0], // Display the first initial of the name
            style: TextStyle(
              fontSize: 50.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          client.name,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          client.address,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        OutlinedButton(
          onPressed: () {
            showMaterialModalBottomSheet(
              expand: true,
              context: context,
              builder: (context) => const EditClientScreen(),
            );
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          child: Text('Edit Profile',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
        ),
      ],
    ),
  );
}

Widget participantDetails(
    BuildContext context, String participantName, String participantNumber) {
  return Card.outlined(
    color: Theme.of(context).colorScheme.surfaceContainerLowest,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Participant Name'),
            subtitle: Text(participantName),
            leading: Icon(
              Iconsax.profile_circle5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(
            height: 2.0,
            thickness: 0.5,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Participant Number'),
            subtitle: Text(participantNumber),
            leading: Icon(
              Iconsax.card5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget participantCareTypes(
    BuildContext context, List<CareTypeEntity> careTypes) {
  return Card.outlined(
    color: Theme.of(context).colorScheme.surfaceContainerLowest,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: careTypes.length,
        itemBuilder: (context, index) {
          final careType = careTypes[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(careType.careTitle),
            subtitle: Text(careType.description),
            leading: Icon(
              Iconsax.mask_25,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    ),
  );
}

Widget buildRatePill(BuildContext context, RateEntity rates) {
  final rateMap = {
    'Mon': rates.monday,
    'Tue': rates.tuesday,
    'Wed': rates.wednesday,
    'Thu': rates.thursday,
    'Fri': rates.friday,
    'Sat': rates.saturday,
    'Sun': rates.sunday,
    'Pub': rates.publicHoliday,
  };

  return Card.outlined(
    color: Theme.of(context).colorScheme.surfaceContainerLowest,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: rateMap.entries.map((entry) {
              final day = entry.key;
              final rate = entry.value ?? 0.0;
              return Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$${rate.toStringAsFixed(1)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
