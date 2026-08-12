import 'package:flutter/material.dart';

import '../helpers/auth_redirect_helper.dart';
import 'email_verification_screen.dart';
import 'reset_password_screen.dart';
import 'fallback_screen.dart';

class AuthRedirectScreen extends StatelessWidget {
  const AuthRedirectScreen({super.key, this.initialUri});

  final Uri? initialUri;

  @override
  Widget build(BuildContext context) {
    final uri = initialUri ?? Uri.base;
    final urlParams = collectRedirectParameters(uri);
    final pathName = getLastPath(uri.path);

    switch (pathName) {
      case EmailVerificationScreen.pathName:
        return EmailVerificationScreen(
          urlParams: urlParams,
        );
      case ResetPasswordScreen.pathName:
        return ResetPasswordScreen(
          urlParams: urlParams,
        );
      default:
        return const FallbackScreen(
          title: "Path Doesn't Exist",
          message: "Oops! It seems you've arrived at the wrong destination",
        );
    }
  }
}
