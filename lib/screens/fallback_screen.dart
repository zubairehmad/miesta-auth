import 'package:flutter/material.dart';

import '../widgets/redirect_status_card.dart';

class FallbackScreen extends StatelessWidget {
  const FallbackScreen({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return RedirectStatusCard(
      title: 'No verification data found',
      message: message,
      icon: Icons.link_off_rounded,
    );
  }
}