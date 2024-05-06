import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final bool isElevated; // To differentiate between elevated and text buttons
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isBoldText;

  const CustomActionButton({
    required this.label,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.isElevated = true, // Default to an ElevatedButton style
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    this.borderRadius = 8.0,
    this.isBoldText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor ?? Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
    );

    final textStyle = TextStyle(
      fontSize: 18,
      color: textColor ?? Theme.of(context).colorScheme.onSecondary,
      fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal,
    );

    return isElevated
        ? ElevatedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(label, style: textStyle),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label, style: textStyle),
          );
  }
}
