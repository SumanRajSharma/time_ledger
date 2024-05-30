import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TimeTextButtons extends StatelessWidget {
  final DateTime? clockInTime;
  final DateTime? clockOutTime;
  final Duration? totalWorkDuration;

  const TimeTextButtons({
    Key? key,
    required this.clockInTime,
    required this.clockOutTime,
    required this.totalWorkDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TimeTextButton(
          icon: Iconsax.clock,
          iconColor: Colors.green,
          label: 'Clock In',
          time: _getClockInTime(),
        ),
        TimeTextButton(
          icon: Iconsax.clock,
          iconColor: Theme.of(context).colorScheme.error,
          label: 'Clock Out',
          time: _getClockOutTime(),
        ),
        TimeTextButton(
          icon: Iconsax.clock,
          iconColor: Colors.blue,
          label: 'Total Hrs',
          time: _formatDuration(totalWorkDuration ?? Duration.zero),
        ),
      ],
    );
  }

  String _getClockInTime() {
    return clockInTime != null
        ? DateFormat('h:mm a').format(clockInTime!)
        : '--:--';
  }

  String _getClockOutTime() {
    return clockOutTime != null
        ? DateFormat('h:mm a').format(clockOutTime!)
        : '--:--';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$hours:$minutes';
  }
}

class TimeTextButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String time;

  const TimeTextButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: iconColor),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
