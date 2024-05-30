import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;

  const CustomAppBar({
    super.key,
    required this.selectedIndex,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Row(
        children: [
          Image.asset('assets/logo/logo2.png', width: 24, height: 24),
          const SizedBox(width: 8),
          Text('Time Ledger',
              style: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
      // actions: [
      //   if (selectedIndex == 1) _buildExtraIcon(context),
      //   _buildMenuButton(context),
      // ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildExtraIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Iconsax.calendar_1),
      onPressed: () async {
        //   final DateTime? picked = await showDatePicker(
        //     context: context,
        //     initialDate: selectedDate ?? DateTime.now(),
        //     firstDate: DateTime(2000),
        //     lastDate: DateTime(2101),
        //     builder: (BuildContext context, Widget? child) {
        //       // Wrapping the DatePicker with CustomDatePickerTheme
        //       return CustomDatePickerTheme(child: child);
        //     },
        //   );
        //   if (picked != null && picked != selectedDate) {
        //     onDateSelected(picked);
        //   }
      },
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Iconsax.setting_2),
      onPressed: () {
        // showMaterialModalBottomSheet(
        //   context: context,
        //   builder: (context) => const SettingsPage(),
        //   expand: false,
        // );
      },
    );
  }
}
