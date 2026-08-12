import 'package:flutter/material.dart';

import '../widgets/redirect_status_card.dart';

class FallbackScreen extends StatelessWidget {
  const FallbackScreen({
    super.key,
    this.title = 'No verification data found',
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return RedirectStatusCard(
      title: title,
      message: message,
      icon: Icons.link_off_rounded,
    );
  }
}