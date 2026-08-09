import 'package:flutter/material.dart';

import '../helpers/auth_redirect_helper.dart';
import '../widgets/redirect_status_card.dart';
import 'email_verification_screen.dart';
import 'fallback_screen.dart';

class AuthRedirectScreen extends StatelessWidget {
  const AuthRedirectScreen({super.key, this.initialUri});

  final Uri? initialUri;

  @override
  Widget build(BuildContext context) {
    final uri = initialUri ?? Uri.base;
    final parameters = collectRedirectParameters(uri);

    if (!isVerifyEmailPath(uri.path)) {
      return const FallbackScreen(
        message:
            'This page only handles email verification redirects at /verify-email.',
      );
    }

    final hasCode = (parameters['code'] ?? '').trim().isNotEmpty;
    final redirectError = extractRedirectErrorMessage(parameters);

    if (hasCode) {
      return const EmailVerificationScreen(
        message:
            'Email verified, now you may login to your account with your credentials',
      );
    }

    if (redirectError != null) {
      return RedirectStatusCard(
        title: 'Email verification failed',
        message: 'Email link is invalid or has expired.\n\n$redirectError',
        icon: Icons.error_outline_rounded,
      );
    }

    return FallbackScreen(message: buildRedirectFallbackMessage(parameters));
  }
}
