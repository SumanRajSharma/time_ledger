import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:time_ledger/core/util/keyboard_visibility_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/custom_action_button_widget.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_bloc.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_event.dart';
import 'package:time_ledger/features/user/presentation/bloc/create_user_state.dart';
import 'package:time_ledger/features/user/presentation/widgets/create_user_widgets/app_bar.dart';
import 'package:time_ledger/features/user/presentation/widgets/create_user_widgets/register_text.dart';
import 'package:time_ledger/injection_container.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  CreateUserPageState createState() => CreateUserPageState();
}

class CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNodes.addAll([
      _emailFocusNode,
      _passwordFocusNode,
      _rePasswordFocusNode,
      _fullNameFocusNode,
      _phoneNumberFocusNode,
    ]);
    _textControllers.addAll([
      _fullNameController,
      _emailController,
      _passwordController,
      _rePasswordController,
      _phoneNumberController,
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
    return BlocProvider<CreateUserBloc>(
      create: (context) => sl<CreateUserBloc>(),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: const RegisterPageAppBar(),
          body: BlocConsumer<CreateUserBloc, CreateUserState>(
            listener: (context, state) {
              if (state is CreateUserFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.error,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.onError),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ));
              }
              if (state is CreateUserSuccess) {
                context.loaderOverlay.hide();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Registration successful. You can now log in.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ));
              }
            },
            builder: (context, state) {
              if (state is CreateUserLoading) {
                context.loaderOverlay.show(progress: 'Signing Up..');
              }
              return _buildLoginForm(context, isKeyboardVisible);
            },
          ),
        );
      }),
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isKeyboardVisible) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RegisterPageText(),
                    const SizedBox(height: 20),
                    AnimatedTextField(
                      textController: _fullNameController,
                      textFocusNode: _fullNameFocusNode,
                      label: 'Full Name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    AnimatedTextField(
                      textController: _passwordController,
                      textFocusNode: _passwordFocusNode,
                      label: 'Password',
                      isObscure: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Please enter a valid password with at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AnimatedTextField(
                      textController: _rePasswordController,
                      textFocusNode: _rePasswordFocusNode,
                      label: 'Confirm Password',
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 40),
                    CustomActionButton(
                      label: 'Register',
                      onPressed: () => _onRegisterButtonPressed(context),
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final createUserBloc = BlocProvider.of<CreateUserBloc>(context);
      createUserBloc.add(
        RegisterButtonPressed(
          fullName: _fullNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phoneNumberController.text,
        ),
      );
    }
  }
}
