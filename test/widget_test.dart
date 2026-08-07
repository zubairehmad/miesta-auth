import 'package:flutter_test/flutter_test.dart';

import 'package:miesta_auth/app.dart';
import 'package:miesta_auth/models/redirect_verification_result.dart';
import 'package:miesta_auth/services/auth_redirect_verifier.dart';

class _FakeAuthRedirectVerifier implements AuthRedirectVerifier {
  _FakeAuthRedirectVerifier(this.result);

  final RedirectVerificationResult result;

  @override
  Future<RedirectVerificationResult> verify(Uri uri) async => result;
}

void main() {
  testWidgets('shows the fallback page when no redirect parameters are present', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse('https://miesta.example/'),
        redirectVerifier: _FakeAuthRedirectVerifier(
          const RedirectVerificationResult.fallback(
            message:
                'Open the link sent by Miesta to continue the verification process.',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No verification data found'), findsOneWidget);
    expect(
      find.text(
        'Open the link sent by Miesta to continue the verification process.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows the verification success message for email redirects', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse(
          'https://miesta.example/auth/callback?type=email_confirmation',
        ),
        redirectVerifier: _FakeAuthRedirectVerifier(
          const RedirectVerificationResult.verified(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Email verified'), findsOneWidget);
    expect(
      find.text(
        'Email verified, now you may login to your account with your credentials',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows expired state for expired verification links', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse(
          'https://miesta.example/auth/callback?token_hash=abc&type=email',
        ),
        redirectVerifier: _FakeAuthRedirectVerifier(
          const RedirectVerificationResult.expired(
            message: 'This verification link has expired.',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Verification link expired'), findsOneWidget);
    expect(find.text('This verification link has expired.'), findsOneWidget);
  });

  testWidgets('shows invalid state for invalid verification links', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MiestaApp(
        initialUri: Uri.parse(
          'https://miesta.example/auth/callback?token_hash=abc&type=email',
        ),
        redirectVerifier: _FakeAuthRedirectVerifier(
          const RedirectVerificationResult.invalid(
            message:
                'Unsupported verification link type in redirect parameters.',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Invalid verification link'), findsOneWidget);
    expect(
      find.text('Unsupported verification link type in redirect parameters.'),
      findsOneWidget,
    );
  });
}
