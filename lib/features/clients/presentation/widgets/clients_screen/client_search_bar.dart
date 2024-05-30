import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ClientSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const ClientSearchBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search clients...',
          prefixIcon: const Icon(Iconsax.search_normal),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
