import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';

class CreateClientAddressPage extends StatefulWidget {
  const CreateClientAddressPage({super.key});

  @override
  State<CreateClientAddressPage> createState() =>
      _CreateClientAddressPageState();
}

class _CreateClientAddressPageState extends State<CreateClientAddressPage> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  final TextEditingController _streeNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final FocusNode _streetNameFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _postCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNodes.addAll([
      _streetNameFocusNode,
      _cityFocusNode,
      _stateFocusNode,
      _postCodeFocusNode,
    ]);
    _textControllers.addAll([
      _streeNameController,
      _cityController,
      _stateController,
      _postCodeController,
    ]);

    for (var focusNode in _focusNodes) {
      focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.removeListener(_handleFocusChange);
      focusNode.dispose();
    }
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Address',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _streeNameController,
            textFocusNode: _streetNameFocusNode,
            label: 'Street Name',
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid Street Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _cityController,
            textFocusNode: _cityFocusNode,
            label: 'Suburb',
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid Suburb Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _stateController,
            textFocusNode: _stateFocusNode,
            label: 'State',
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid state';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _postCodeController,
            textFocusNode: _postCodeFocusNode,
            label: 'Postal Code',
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid Postal code';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
