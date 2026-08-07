import 'package:supabase_flutter/supabase_flutter.dart';

import '../helpers/auth_redirect_helper.dart';
import '../models/redirect_verification_result.dart';

abstract class AuthRedirectVerifier {
  Future<RedirectVerificationResult> verify(Uri uri);
}

class SupabaseAuthRedirectVerifier implements AuthRedirectVerifier {
  SupabaseAuthRedirectVerifier({
    required this.isSupabaseConfigured,
    this.client,
  });

  factory SupabaseAuthRedirectVerifier.fromEnvironment() {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      return SupabaseAuthRedirectVerifier(isSupabaseConfigured: false);
    }

    return SupabaseAuthRedirectVerifier(
      isSupabaseConfigured: true,
      client: Supabase.instance.client,
    );
  }

  final SupabaseClient? client;
  final bool isSupabaseConfigured;

  @override
  Future<RedirectVerificationResult> verify(Uri uri) async {
    final parameters = collectRedirectParameters(uri);
    if (parameters.isEmpty) {
      return const RedirectVerificationResult.fallback(
        message:
            'Open the link sent by Miesta to continue the verification process.',
      );
    }

    final redirectError = extractSupabaseErrorMessage(parameters);
    if (redirectError != null) {
      return _expiredOrInvalid(redirectError);
    }

    if (!isSupabaseConfigured || client == null) {
      return const RedirectVerificationResult.invalid(
        message:
            'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY to verify this link.',
      );
    }

    final authCode = parameters['code'];
    if (authCode != null && authCode.isNotEmpty) {
      try {
        await client!.auth.exchangeCodeForSession(authCode);
        return const RedirectVerificationResult.verified();
      } on AuthException catch (error) {
        return _expiredOrInvalid(error.message);
      }
    }

    final tokenHash = parameters['token_hash'];
    if (tokenHash != null && tokenHash.isNotEmpty) {
      final otpType = _resolveOtpType(parameters);
      if (otpType == null) {
        return const RedirectVerificationResult.invalid(
          message: 'Unsupported verification link type in redirect parameters.',
        );
      }

      try {
        await client!.auth.verifyOTP(type: otpType, tokenHash: tokenHash);
        return const RedirectVerificationResult.verified();
      } on AuthException catch (error) {
        return _expiredOrInvalid(error.message);
      }
    }

    return RedirectVerificationResult.fallback(
      message: buildRedirectFallbackMessage(parameters),
    );
  }

  RedirectVerificationResult _expiredOrInvalid(String rawMessage) {
    final message = rawMessage.trim();
    if (isLikelyExpiredError(message)) {
      return RedirectVerificationResult.expired(message: message);
    }
    return RedirectVerificationResult.invalid(message: message);
  }

  OtpType? _resolveOtpType(Map<String, String> parameters) {
    final rawType = (parameters['type'] ?? '').trim().toLowerCase();
    switch (rawType) {
      case 'email':
      case 'email_confirmation':
      case 'confirmation':
        return OtpType.email;
      case 'signup':
        return OtpType.signup;
      case 'invite':
        return OtpType.invite;
      case 'magiclink':
      case 'magic_link':
        return OtpType.magiclink;
      case 'recovery':
        return OtpType.recovery;
      case 'email_change':
      case 'email_change_new':
      case 'email_change_current':
        return OtpType.emailChange;
      default:
        return null;
    }
  }
}
