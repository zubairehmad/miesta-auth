import 'package:flutter/material.dart';

import 'screens/auth_redirect_screen.dart';
import 'services/auth_redirect_verifier.dart';
import 'theme/app_theme.dart';

class MiestaApp extends StatelessWidget {
  const MiestaApp({super.key, this.initialUri, this.redirectVerifier});

  final Uri? initialUri;
  final AuthRedirectVerifier? redirectVerifier;

  @override
  Widget build(BuildContext context) {
    final verifier =
        redirectVerifier ?? SupabaseAuthRedirectVerifier.fromEnvironment();

    return MaterialApp(
      title: 'Miesta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AuthRedirectScreen(
        initialUri: initialUri,
        redirectVerifier: verifier,
      ),
    );
  }
}
