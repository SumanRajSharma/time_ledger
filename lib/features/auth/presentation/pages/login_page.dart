import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:time_ledger/core/util/keyboard_visibility_widget.dart';
import 'package:time_ledger/features/auth/domain/usecases/manage_authentication.dart';
import 'package:time_ledger/features/auth/presentation/widgets/animated_textfield_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/custom_action_button_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/login_page_widgets/forgot_password_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/login_page_widgets/login_text_widget.dart';
import 'package:time_ledger/features/auth/presentation/widgets/login_page_widgets/logo_widget.dart';
import 'package:time_ledger/features/user/presentation/pages/home/create_user.dart';
import 'package:time_ledger/injection_container.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_bloc.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_event.dart';
import 'package:time_ledger/features/auth/presentation/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_handleFocusChange);
    _passwordFocusNode.removeListener(_handleFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final manageAuth = sl<ManageAuthentication>();
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
          body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
              if (state is LoginSuccess) {
                context.loaderOverlay.hide();
                manageAuth.login();
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                context.loaderOverlay.show(progress: 'Signing In..');
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
                    LogoAnimationWidget(
                      context,
                      isKeyboardVisible: isKeyboardVisible,
                    ),
                    const SizedBox(height: 20),
                    const LoginText(),
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
                    const ForgotPasswordButton(),
                    const SizedBox(height: 20),
                    CustomActionButton(
                      label: 'Login',
                      onPressed: () => _onLoginButtonPressed(context),
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        CustomActionButton(
                          label: 'Register',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateUserPage()),
                            );
                          },
                          isElevated: false,
                          isBoldText: true,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
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

  void _onLoginButtonPressed(BuildContext context) {
    // Dismiss the keyboard
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }
}
