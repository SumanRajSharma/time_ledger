import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final String loadingText;

  const LoadingOverlay({
    super.key,
    this.loadingText = 'Loading...', // Default loading text
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45, // Semi-transparent black background
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  loadingText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
