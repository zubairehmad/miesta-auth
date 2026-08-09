import 'package:flutter_test/flutter_test.dart';

import 'package:miesta_auth/app.dart';

void main() {
  testWidgets('shows fallback when redirect path is not /verify-email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(initialUri: Uri.parse('https://miesta.example/?code=abc')),
    );

    expect(find.text('No verification data found'), findsOneWidget);
    expect(
      find.text(
        'This page only handles email verification redirects at /verify-email.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows success when code is present on /verify-email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse(
          'https://miesta.example/verify-email?code=1591fdf0-e9b2-4d45-afe5-da0d181c0aaf',
        ),
      ),
    );

    expect(find.text('Email verified'), findsOneWidget);
    expect(
      find.text(
        'Email verified, now you may login to your account with your credentials',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows invalid or expired message when error is present', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse(
          'https://miesta.example/verify-email?error=access_denied&error_code=otp_expired&error_description=Email+link+is+invalid+or+has+expired#error=access_denied&error_code=otp_expired&error_description=Email+link+is+invalid+or+has+expired&sb=',
        ),
      ),
    );

    expect(find.text('Email verification failed'), findsOneWidget);
    expect(
      find.textContaining('Email link is invalid or has expired.'),
      findsOneWidget,
    );
  });

  testWidgets('shows fallback when no code or error exists on /verify-email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(initialUri: Uri.parse('https://miesta.example/verify-email')),
    );

    expect(find.text('No verification data found'), findsOneWidget);
    expect(
      find.text('No verification data was found in this redirect.'),
      findsOneWidget,
    );
  });
}
