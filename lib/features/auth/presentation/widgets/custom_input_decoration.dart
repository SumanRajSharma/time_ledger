import 'package:flutter/material.dart';

InputDecoration customInputDecoration({
  required String label,
  required FocusNode focusNode,
  required BuildContext context,
}) {
  // Retrieve theme colors
  final theme = Theme.of(context);
  final Color primaryColor = theme.colorScheme.primary;
  final Color errorColor = theme.colorScheme.error;
  final Color enabledBorderColor = theme.colorScheme.outline;
  final Color unfocusedBorderColor = theme.colorScheme.secondary;

  // Create a border style
  OutlineInputBorder createBorder(Color color) {
    return OutlineInputBorder(
      // borderRadius: BorderRadius.circular(8.0), // Rounded corners
      borderSide: BorderSide(color: color, width: 0.8),
    );
  }

  // Determine border color based on focus state
  final Color borderColor =
      focusNode.hasFocus ? primaryColor : unfocusedBorderColor;

  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: borderColor, // Adjust label color based on focus state
      fontSize: 16,
    ),
    floatingLabelStyle: TextStyle(
      color: focusNode.hasFocus ? primaryColor : unfocusedBorderColor,
      fontSize: 16,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

    // Borders for different states
    enabledBorder: createBorder(enabledBorderColor),
    focusedBorder: createBorder(primaryColor),
    errorBorder: createBorder(errorColor),
    focusedErrorBorder: createBorder(errorColor),
  );
}
