import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/profile_screen.dart';

class ThemeCard extends StatelessWidget {
  final ThemeOptions themeOption;
  final ValueChanged<ThemeOptions> onThemeChanged;

  const ThemeCard({
    super.key,
    required this.themeOption,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Map<ThemeOptions, Widget> themeSegments = {
      ThemeOptions.system:
          _buildSegment('System', themeOption == ThemeOptions.system, context),
      ThemeOptions.light:
          _buildSegment('Light', themeOption == ThemeOptions.light, context),
      ThemeOptions.dark:
          _buildSegment('Dark', themeOption == ThemeOptions.dark, context),
    };

    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Icon(
              Iconsax.sun_15,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Theme',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                primaryColor: Theme.of(context).colorScheme.error,
              ),
              child: SizedBox(
                height: 65, // Specify the height of the segmented control.
                child: CupertinoSlidingSegmentedControl<ThemeOptions>(
                  groupValue: themeOption,
                  children: themeSegments,
                  onValueChanged: (ThemeOptions? value) {
                    if (value != null) {
                      onThemeChanged(value);
                    }
                  },
                  thumbColor: Theme.of(context).colorScheme.primary,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(String text, bool isSelected, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10), // Add vertical padding
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
