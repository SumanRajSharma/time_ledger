import 'package:flutter/material.dart';

class LogoAnimationWidget extends StatelessWidget {
  final bool isKeyboardVisible;

  const LogoAnimationWidget(BuildContext context,
      {required this.isKeyboardVisible, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: isKeyboardVisible ? 100 : screenHeight * 0.3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: isKeyboardVisible ? 60 : 100,
              width: isKeyboardVisible ? 60 : 100,
              child: Image.asset('assets/logo/logo2.png'),
            ),
            const SizedBox(height: 8),
            AnimatedDefaultTextStyle(
              style: theme.textTheme.headlineMedium!.copyWith(
                fontSize: isKeyboardVisible ? 20 : 34,
                color: theme.colorScheme.tertiary,
                fontFamily: 'Bangers',
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Text(
                'Time Ledger',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
