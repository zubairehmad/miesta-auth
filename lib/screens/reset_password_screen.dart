import 'package:flutter/material.dart';

import '../helpers/auth_redirect_helper.dart';
import '../services/auth_actions.dart';
import '../widgets/redirect_status_card.dart';
import '../widgets/reset_password_screen/password_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const pathName = '/reset-password';
  final Map<String, String> urlParams;

  const ResetPasswordScreen({
    super.key,
    required this.urlParams,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordChanged = false;
  bool _isLoading = false;
  String? _passwordErrText;

  Future<void> _handleConfirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      if (_passwordErrText != null) setState(() => _passwordErrText = null);
      return;
    }

    setState(() {
      _isLoading = true;
      _passwordErrText = null;
    });

    final retCode = await AuthActions.updatePassword(_passwordController.text);

    String? errorText;

    switch (retCode) {
      case null:
        await AuthActions.signOut();
        setState(() => _passwordChanged = true);
        break;
      case 'same-password':
        _passwordErrText = 'This password is same as current password';
        break;
      case 'weak-password':
        _passwordErrText = 'Please choose a strong password';
        break;
      case 'no-user-present':
      case 'user-token-expired':
        errorText =
            'Session has expired, you will have to request another reset password email.';
        break;
      case 'network-request-failed':
        errorText = 'Please check your internet connection.';
        break;
      default:
        errorText = 'Unexpected error occured! Please retry after a while.';
    }

    if (!mounted) return;

    if (errorText != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorText)),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_passwordChanged) {
      return RedirectStatusCard(
        title: 'Password Changed Successfully!',
        message: 'You may now proceed to login with your updated password.',
        icon: Icons.verified_rounded,
      );
    } else if (isThereRedirectError(widget.urlParams) ||
        !AuthActions.hasSession) {
      return RedirectStatusCard(
        title: 'Reset Password Failed',
        message: 'The link is invalid or has expired',
        icon: Icons.error_outline_outlined,
      );
    }

    return RedirectStatusCard(
      child: Flexible(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Update your password',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  PasswordForm(
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    passwordErrText: _passwordErrText,
                    disable: _isLoading,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleConfirm,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
