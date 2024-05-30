import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';

class CreateClientInfoPage extends StatefulWidget {
  const CreateClientInfoPage({super.key});

  @override
  State<CreateClientInfoPage> createState() => _CreateClientInfoPageState();
}

class _CreateClientInfoPageState extends State<CreateClientInfoPage> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _participantNameController =
      TextEditingController();
  final TextEditingController _participantNumberController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _participantNameFocusNode = FocusNode();
  final FocusNode _participantNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNodes.addAll([
      _nameFocusNode,
      _participantNameFocusNode,
      _participantNumberFocusNode,
    ]);
    _textControllers.addAll([
      _nameController,
      _participantNameController,
      _participantNumberController
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Information',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _nameController,
            textFocusNode: _nameFocusNode,
            label: 'Name',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _participantNameController,
            textFocusNode: _participantNameFocusNode,
            label: 'Participant\'s Name',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _participantNumberController,
            textFocusNode: _participantNumberFocusNode,
            label: 'Participant\'s Number',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid participant number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
