import 'package:flutter/material.dart';

class WeeklyCardDay extends StatelessWidget {
  final String day;
  final String date;
  final bool isFilled;

  const WeeklyCardDay({
    super.key,
    required this.day,
    required this.date,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 72.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isFilled
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            date,
            style: TextStyle(
              color: isFilled
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
