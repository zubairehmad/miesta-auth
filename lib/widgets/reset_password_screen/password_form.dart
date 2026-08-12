import 'package:flutter/material.dart';

import '../../helpers/input_validator.dart';
import 'auth_form_field.dart';

class PasswordForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? passwordErrText;
  final String? confirmPasswordErrText;
  final bool disable;

  const PasswordForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    this.disable = false,
    this.passwordErrText,
    this.confirmPasswordErrText,
  });

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _isVisible = false;

  void _onVisibilityChanged(bool isHidden) {
    setState(() => _isVisible = !isHidden);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthFormField(
          maxLength: 64,
          isPasswordField: true,
          obsecureText: !_isVisible,
          handleVisibilityManually: true,
          onVisibilityChanged: _onVisibilityChanged,
          hintText: 'Choose a new password',
          controller: widget.passwordController,
          validator: InputValidator.validatePassword,
          errorText: widget.passwordErrText,
          disable: widget.disable,
          icon: const Icon(Icons.lock_outlined),
        ),
        const SizedBox(height: 18),
        AuthFormField(
          maxLength: 64,
          isPasswordField: true,
          obsecureText: !_isVisible,
          handleVisibilityManually: true,
          onVisibilityChanged: _onVisibilityChanged,
          hintText: 'Confirm your new password',
          controller: widget.confirmPasswordController,
          validator: (value) => InputValidator.validateConfirmPassword(
            value,
            widget.passwordController.text,
          ),
          errorText: widget.confirmPasswordErrText,
          disable: widget.disable,
          icon: const Icon(Icons.lock_outlined),
        ),
      ],
    );
  }
}
