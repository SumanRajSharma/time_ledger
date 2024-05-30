import 'package:flutter/material.dart';

class ClockActionButton extends StatelessWidget {
  final bool isClockedIn;
  final VoidCallback onPressed;

  const ClockActionButton({
    super.key,
    required this.isClockedIn,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isClockedIn
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        elevation: 4,
        padding: const EdgeInsets.all(24),
        fixedSize: const Size(200, 200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.touch_app,
              color: Theme.of(context).colorScheme.onPrimary, size: 58),
          const SizedBox(height: 10),
          Text(
            isClockedIn ? 'Clock Off' : 'Clock On',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
