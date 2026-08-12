import 'package:flutter/material.dart';

import '../helpers/auth_redirect_helper.dart';
import '../services/auth_actions.dart';
import '../widgets/redirect_status_card.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const pathName = '/verify-email';
  final Map<String, String> urlParams;

  const EmailVerificationScreen({
    super.key,
    required this.urlParams,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late final bool hasSession;

  @override
  void initState() {
    super.initState();

    hasSession = AuthActions.hasSession;
    if (hasSession) {
      AuthActions.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isThereRedirectError(widget.urlParams) || !hasSession) {
      return RedirectStatusCard(
        title: 'Email verification failed',
        message: 'The link is invalid or has expired.',
        icon: Icons.error_outline_outlined,
      );
    }

    return RedirectStatusCard(
      title: 'Email verified',
      message:
          'Email verified, now you may login to your account with your credentials',
      icon: Icons.verified_rounded,
    );
  }
}
