import 'package:flutter/material.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/presentation/pages/client_details_screen.dart';

class ClientsListView extends StatelessWidget {
  final List<ClientEntity> clients;
  final Future<void> Function()
      onRefresh; // Callback function for refreshing the list

  const ClientsListView(
      {super.key, required this.clients, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16.0),
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                client
                    .name[0], // Display the initial letter of the client's name
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary), // You can customize the background color
              ),
            ),
            title: Text(
              client.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.address,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildRatePills(context, client),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientDetailsScreen(client: client),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          );
        },
      ),
    );
  }

  List<Widget> buildRatePills(BuildContext context, ClientEntity client) {
    final rates = {
      'Mon': client.rate.monday,
      'Tue': client.rate.tuesday,
      'Wed': client.rate.wednesday,
      'Thu': client.rate.thursday,
      'Fri': client.rate.friday,
      'Sat': client.rate.saturday,
      'Sun': client.rate.sunday,
      'Pub': client.rate.publicHoliday,
    };

    return rates.entries.map((entry) {
      final day = entry.key;
      final rate = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Text(
          '${day[0]} \$$rate',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8)),
        ),
      );
    }).toList();
  }
}
