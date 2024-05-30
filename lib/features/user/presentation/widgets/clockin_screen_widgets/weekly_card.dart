import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/widgets/clockin_screen_widgets/weekly_card_day.dart';

class WeeklyCard extends StatelessWidget {
  final UserEntity user;

  const WeeklyCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const List<String> dates = ['24', '25', '26', '27', '28', '29', '30'];
    final Set<int> filledDays = {0, 2, 4, 6};

    return Card.filled(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Days Worked This Week',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(days.length, (index) {
                bool isFilled = filledDays.contains(index);
                return WeeklyCardDay(
                  day: days[index],
                  date: dates[index],
                  isFilled: isFilled,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
