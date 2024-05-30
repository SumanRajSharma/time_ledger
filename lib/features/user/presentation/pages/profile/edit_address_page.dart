import 'package:flutter/material.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';
import 'package:time_ledger/features/user/domain/entities/get_user.dart';
import 'package:time_ledger/features/user/presentation/widgets/user_profile_screen/address_helper.dart';

class EditAddressPage extends StatefulWidget {
  final UserEntity user;
  const EditAddressPage({super.key, required this.user});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  late TextEditingController _streeNameController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postCodeController;
  final FocusNode _streetNameFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _postCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Parse the address
    final parsedAddress = parseAddress(widget.user.address);

    _focusNodes.addAll([
      _streetNameFocusNode,
      _cityFocusNode,
      _stateFocusNode,
      _postCodeFocusNode,
    ]);
    _textControllers.addAll([
      _streeNameController = TextEditingController(
          text: '${parsedAddress.streetNumber} ${parsedAddress.streetName}'),
      _cityController = TextEditingController(text: parsedAddress.suburb),
      _stateController = TextEditingController(text: parsedAddress.state),
      _postCodeController =
          TextEditingController(text: parsedAddress.postalCode),
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
          Text('Address',
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
