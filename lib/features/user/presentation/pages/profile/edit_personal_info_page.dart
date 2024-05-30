import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final UserEntity user;
  const EditPersonalInfoPage({super.key, required this.user});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _abnController;
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _abnFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNodes.addAll([
      _emailFocusNode,
      _fullNameFocusNode,
      _abnFocusNode,
      _phoneNumberFocusNode,
    ]);
    _textControllers.addAll([
      _fullNameController = TextEditingController(text: widget.user.fullName),
      _emailController = TextEditingController(text: widget.user.email),
      _abnController = TextEditingController(text: widget.user.abn),
      _phoneNumberController =
          TextEditingController(text: widget.user.phoneNumber),
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
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _fullNameController,
            textFocusNode: _fullNameFocusNode,
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
            textController: _emailController,
            textFocusNode: _emailFocusNode,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _phoneNumberController,
            textFocusNode: _phoneNumberFocusNode,
            label: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _abnController,
            textFocusNode: _abnFocusNode,
            label: 'ABN',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an ABN';
              } else if (value.length != 11) {
                return 'ABN must be 11 digits';
              } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                return 'ABN must be 11 digits long and numeric';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
