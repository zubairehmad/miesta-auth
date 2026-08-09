import 'package:flutter/material.dart';

import 'screens/auth_redirect_screen.dart';
import 'theme/app_theme.dart';

class MiestaApp extends StatelessWidget {
  const MiestaApp({super.key, this.initialUri});

  final Uri? initialUri;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miesta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AuthRedirectScreen(initialUri: initialUri),
    );
  }
}
