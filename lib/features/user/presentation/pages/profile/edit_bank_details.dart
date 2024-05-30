import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';

class EditBankDetailsPage extends StatefulWidget {
  final UserEntity user;
  const EditBankDetailsPage({super.key, required this.user});

  @override
  State<EditBankDetailsPage> createState() => _EditBankDetailsPageState();
}

class _EditBankDetailsPageState extends State<EditBankDetailsPage> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  late TextEditingController _accountNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _bsbController;
  final FocusNode _accountNameFocusNode = FocusNode();
  final FocusNode _accountNumberFocusNode = FocusNode();
  final FocusNode _bsbFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNodes.addAll([
      _accountNameFocusNode,
      _accountNumberFocusNode,
      _bsbFocusNode,
    ]);
    _textControllers.addAll([
      _accountNameController =
          TextEditingController(text: widget.user.bankDetails?.accountName),
      _accountNumberController =
          TextEditingController(text: widget.user.bankDetails?.accountNumber),
      _bsbController =
          TextEditingController(text: widget.user.bankDetails?.bsb),
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
          Text('Bank Details',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _accountNameController,
            textFocusNode: _accountNameFocusNode,
            label: 'Account Name',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid Account Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _accountNumberController,
            textFocusNode: _accountNumberFocusNode,
            label: 'Account Number',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return 'Please enter a valid Account Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          AnimatedTextField(
            textController: _bsbController,
            textFocusNode: _bsbFocusNode,
            label: 'BSB',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid BSB';
              } else if (value.length != 6) {
                return 'BSB must be 6 digits';
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
