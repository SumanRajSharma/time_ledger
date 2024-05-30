import 'package:flutter/material.dart';

class DateTimeDisplay extends StatelessWidget {
  const DateTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              'Monday, 26 April 2024',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            '9:00 AM',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
