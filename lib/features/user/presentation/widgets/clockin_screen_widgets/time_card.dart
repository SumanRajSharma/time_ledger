import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/clock_action_button.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/date_time_display.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/time_text_button.dart';

class TimeCard extends StatelessWidget {
  final bool isClockedIn;
  final DateTime? clockInTime;
  final DateTime? clockOutTime;
  final Duration? totalWorkDuration;
  final VoidCallback onClockButtonPressed;

  const TimeCard({
    super.key,
    required this.isClockedIn,
    required this.clockInTime,
    required this.clockOutTime,
    required this.totalWorkDuration,
    required this.onClockButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      // color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const DateTimeDisplay(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClockActionButton(
                    isClockedIn: isClockedIn,
                    onPressed: onClockButtonPressed,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TimeTextButtons(
                    clockInTime: clockInTime,
                    clockOutTime: clockOutTime,
                    totalWorkDuration: totalWorkDuration,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
