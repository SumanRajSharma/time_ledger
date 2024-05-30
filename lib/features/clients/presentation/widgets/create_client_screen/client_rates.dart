import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateClientRatesPage extends StatefulWidget {
  const CreateClientRatesPage({super.key});

  @override
  _CreateClientRatesPageState createState() => _CreateClientRatesPageState();
}

class _CreateClientRatesPageState extends State<CreateClientRatesPage> {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Public Holiday',
  ];

  final Map<String, double> rates = {
    'Monday': 60.0,
    'Tuesday': 60.0,
    'Wednesday': 60.0,
    'Thursday': 60.0,
    'Friday': 60.0,
    'Saturday': 70.0,
    'Sunday': 80.0,
    'Public Holiday': 120.0,
  };

  int _selectedIndex = 0;

  void _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: daysOfWeek.map((day) {
            int index = daysOfWeek.indexOf(day);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () => _onDaySelected(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: _selectedIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        child: Text(
                          day[0],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 75,
                            child: Text(
                              day,
                              style: TextStyle(
                                color: _selectedIndex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: _selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60, // Fixed width to prevent flickering
                            child: Text(
                              '\$${rates[day]!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: _selectedIndex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(daysOfWeek[_selectedIndex],
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 16.0,
                        thumbShape: CustomSliderThumbCircle(
                            thumbRadius: 32.0,
                            thumbColor: Theme.of(context).colorScheme.primary,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            value: rates[daysOfWeek[_selectedIndex]]!),
                        overlayShape: const RoundSliderOverlayShape(),
                        valueIndicatorShape:
                            const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor:
                            Theme.of(context).colorScheme.primary,
                        valueIndicatorTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        showValueIndicator: ShowValueIndicator.never,
                        activeTrackColor: Theme.of(context).colorScheme.primary,
                        inactiveTrackColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        overlayColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                      ),
                      child: Slider(
                        value: rates[daysOfWeek[_selectedIndex]]!,
                        min: 0,
                        max: 220,
                        divisions: 220,
                        label: rates[daysOfWeek[_selectedIndex]]!
                            .toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            rates[daysOfWeek[_selectedIndex]] = value;
                          });
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbColor;
  final Color textColor;
  final double value;
  final double fixedWidth; // Add fixed width parameter

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.thumbColor,
    required this.textColor,
    required this.value,
    this.fixedWidth = 40.0, // Default fixed width
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * 0.8,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      text: getValue(this.value),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout(minWidth: fixedWidth); // Set a fixed width for the text layout

    // Apply rotation to the text painter
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(1.5708); // Rotate by +90 degrees (in radians)
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  String getValue(double value) {
    return value.round().toString();
  }
}
