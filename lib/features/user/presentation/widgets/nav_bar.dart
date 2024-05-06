import 'package:google_nav_bar/google_nav_bar.dart';
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
  final double boxShadowBlur = 8;
  final Offset boxShadowOffset = const Offset(0, -3);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 12.0),
                child: GNav(
                  rippleColor: theme.colorScheme.tertiary.withOpacity(0.1),
                  hoverColor: theme.colorScheme.tertiary.withOpacity(0.1),
                  gap: 8,
                  activeColor: theme.colorScheme.onTertiary.withOpacity(0.7),
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  duration: const Duration(milliseconds: 600),
                  tabBackgroundColor: theme.colorScheme.tertiary,
                  color: theme.colorScheme.secondary.withOpacity(0.4),
                  tabs: const [
                    GButton(
                      icon: Iconsax.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Iconsax.calendar,
                      text: 'Track',
                    ),
                    GButton(
                      icon: Iconsax.graph,
                      text: 'Dash',
                    ),
                    GButton(
                      icon: Iconsax.directbox_receive,
                      text: 'Invoices',
                    ),
                  ],
                  selectedIndex: widget.selectedIndex,
                  onTabChange: (index) {
                    widget.onItemSelected(index);
                  },
                ))));
  }
}
