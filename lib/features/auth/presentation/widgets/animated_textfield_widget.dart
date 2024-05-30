import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/custom_input_decoration.dart';

class AnimatedTextField extends StatefulWidget {
  final TextEditingController textController;
  final FocusNode textFocusNode;
  final String label;
  final TextInputType keyboardType;
  final bool isObscure; // For password fields
  final String? Function(String?)? validator;

  const AnimatedTextField({
    super.key,
    required this.textController,
    required this.textFocusNode,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.validator,
  });

  @override
  AnimatedTextFieldState createState() => AnimatedTextFieldState();
}

class AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fontSizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fontSizeAnimation = Tween<double>(begin: 16, end: 18).animate(_controller);

    widget.textFocusNode.addListener(() {
      if (widget.textFocusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.textController,
          focusNode: widget.textFocusNode,
          obscureText: widget.isObscure,
          keyboardType: widget.keyboardType,
          decoration: customInputDecoration(
            label: widget.label,
            focusNode: widget.textFocusNode,
            context: context,
          ),
          style: TextStyle(
            fontSize: _fontSizeAnimation.value,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid ${widget.label.toLowerCase()}';
                }
                return null;
              },
        );
      },
    );
  }
}
