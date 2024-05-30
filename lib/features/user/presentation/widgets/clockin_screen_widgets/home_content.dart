import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/greeting_section.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/time_card.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/weekly_card.dart';

class HomeContent extends StatelessWidget {
  final UserEntity user;
  final bool isClockedIn;
  final DateTime? clockInTime;
  final DateTime? clockOutTime;
  final Duration? totalWorkDuration;
  final VoidCallback onClockButtonPressed;

  const HomeContent({
    super.key,
    required this.user,
    required this.isClockedIn,
    required this.clockInTime,
    required this.clockOutTime,
    required this.totalWorkDuration,
    required this.onClockButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GreetingSection(user: user),
          const SizedBox(height: 24.0),
          WeeklyCard(user: user),
          const SizedBox(height: 8.0),
          TimeCard(
            isClockedIn: isClockedIn,
            clockInTime: clockInTime,
            clockOutTime: clockOutTime,
            totalWorkDuration: totalWorkDuration,
            onClockButtonPressed: onClockButtonPressed,
          ),
        ],
      ),
    );
  }
}
