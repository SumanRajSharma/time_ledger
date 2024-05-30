import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> titles;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Step ${currentStep + 1} of $totalSteps',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentStep + 1) / totalSteps,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          minHeight: 8,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalSteps, (index) {
            Color textColor;
            if (index == currentStep) {
              textColor = Theme.of(context).colorScheme.primary;
            } else if (index < currentStep) {
              textColor = Theme.of(context).colorScheme.onSurface;
            } else {
              textColor = Theme.of(context).colorScheme.onSurfaceVariant;
            }

            FontWeight fontWeight =
                index == currentStep ? FontWeight.bold : FontWeight.normal;

            return Text(
              titles[index],
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
              ),
            );
          }),
        ),
      ],
    );
  }
}
