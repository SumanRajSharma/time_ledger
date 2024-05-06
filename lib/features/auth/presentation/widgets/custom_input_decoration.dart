import 'package:flutter/material.dart';

// Convert CustomInputDecoration from a widget to a function that returns InputDecoration
InputDecoration customInputDecoration({
  required String label,
  required FocusNode focusNode,
  required BuildContext context,
}) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Theme.of(context).colorScheme.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    labelStyle: TextStyle(
      color: focusNode.hasFocus
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}
