import 'package:flutter/material.dart';

import '../widgets/redirect_status_card.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return RedirectStatusCard(
      title: 'Email verified',
      message: message,
      icon: Icons.verified_rounded,
    );
  }
}
