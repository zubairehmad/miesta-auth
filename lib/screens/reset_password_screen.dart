import 'package:flutter/material.dart';

import '../helpers/auth_redirect_helper.dart';
import '../widgets/redirect_status_card.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const pathName = '/reset-password';
  final Map<String, String> urlParams;

  const ResetPasswordScreen({
    super.key,
    required this.urlParams,
  });

  @override
  Widget build(BuildContext context) {
    if (isThereRedirectError(urlParams) ||
        !urlParams.containsKey('access_token')) {
      return RedirectStatusCard(
        title: 'Reset Password Failed',
        message: 'The link is invalid or has expired',
        icon: Icons.error_outline_outlined,
      );
    }

    return RedirectStatusCard(
      title: 'Reset Password Redirect',
      message: 'This is reset password redirect',
      icon: Icons.verified_rounded,
    );
  }
}
