import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final Function onLeadingPressed;
  final String? title;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry? margin; // Make margin optional
  final IconData? actionIcon; // Optional action icon
  final Function? onActionPressed; // Optional action function

  CustomAppBar({
    super.key,
    required this.leadingIcon,
    required this.onLeadingPressed,
    this.title,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    this.iconSize = 24.0, // Default icon size, typical of AppBar icons
    this.margin, // Margin is now optional
    this.actionIcon,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply default app bar margin/padding if `margin` is null
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                leadingIcon,
                color: iconColor,
                size: iconSize, // Use the given icon size
              ),
              onPressed: () => onLeadingPressed(),
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 20.0,
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Display an action icon only if provided
            if (actionIcon != null && onActionPressed != null)
              IconButton(
                icon: Icon(
                  actionIcon,
                  color: iconColor,
                  size: iconSize, // Use the given icon size
                ),
                onPressed: () => onActionPressed!(),
              )
            else
              const SizedBox(width: 48), // Placeholder to balance the layout
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
