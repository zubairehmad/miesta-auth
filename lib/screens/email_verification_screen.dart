import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../helpers/auth_redirect_helper.dart';
import '../widgets/redirect_status_card.dart';

class EmailVerificationScreen extends StatelessWidget {
  static const pathName = '/verify-email';
  final Map<String, String> urlParams;

  const EmailVerificationScreen({
    super.key,
    required this.urlParams,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = Supabase.instance.client.auth.currentUser != null;
    if (isThereRedirectError(urlParams) || !isSuccess) {
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
