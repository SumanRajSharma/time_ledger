import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      backgroundColor: theme.colorScheme.surfaceContainer,
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onItemSelected,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Iconsax.home_15,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(Iconsax.home),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Iconsax.calendar_25,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(Iconsax.calendar_2),
          label: 'Track',
        ),
        NavigationDestination(
          selectedIcon: Icon(Iconsax.graph5,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(Iconsax.graph),
          label: 'Dash',
        ),
        NavigationDestination(
          selectedIcon: Icon(Iconsax.directbox_receive5,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(Iconsax.directbox_receive),
          label: 'Invoices',
        ),
        NavigationDestination(
          selectedIcon: Icon(Iconsax.profile_circle5,
              color: Theme.of(context).colorScheme.primary),
          icon: const Icon(Iconsax.profile_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
