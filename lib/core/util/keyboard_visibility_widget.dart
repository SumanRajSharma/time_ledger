import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;

  const KeyboardVisibilityBuilder({
    super.key,
    required this.builder,
  });

  @override
  KeyboardVisibilityBuilderState createState() =>
      KeyboardVisibilityBuilderState();
}

class KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder> {
  late final KeyboardVisibilityController _keyboardVisibilityController;
  late final StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardVisibilitySubscription =
        _keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      }
    });
  }

  @override
  void dispose() {
    _keyboardVisibilitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isKeyboardVisible);
  }
}
