import 'package:flutter/material.dart';

import '../models/redirect_verification_result.dart';
import '../services/auth_redirect_verifier.dart';
import '../widgets/redirect_status_card.dart';
import 'email_verification_screen.dart';
import 'fallback_screen.dart';

class AuthRedirectScreen extends StatefulWidget {
  const AuthRedirectScreen({
    super.key,
    this.initialUri,
    required this.redirectVerifier,
  });

  final Uri? initialUri;
  final AuthRedirectVerifier redirectVerifier;

  @override
  State<AuthRedirectScreen> createState() => _AuthRedirectScreenState();
}

class _AuthRedirectScreenState extends State<AuthRedirectScreen> {
  late final Future<RedirectVerificationResult> _verificationFuture;

  @override
  void initState() {
    super.initState();
    final uri = widget.initialUri ?? Uri.base;
    _verificationFuture = widget.redirectVerifier.verify(uri);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RedirectVerificationResult>(
      future: _verificationFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const RedirectStatusCard(
            title: 'Verifying link',
            message:
                'Please wait while we validate your Miesta verification link.',
            icon: Icons.hourglass_top_rounded,
          );
        }

        final result = snapshot.data!;
        switch (result.status) {
          case RedirectVerificationStatus.verified:
            return EmailVerificationScreen(message: result.message);
          case RedirectVerificationStatus.expired:
            return RedirectStatusCard(
              title: 'Verification link expired',
              message: result.message,
              icon: Icons.timer_off_rounded,
            );
          case RedirectVerificationStatus.invalid:
            return RedirectStatusCard(
              title: 'Invalid verification link',
              message: result.message,
              icon: Icons.error_outline_rounded,
            );
          case RedirectVerificationStatus.fallback:
            return FallbackScreen(message: result.message);
        }
      },
    );
  }
}
