enum RedirectVerificationStatus { verified, expired, invalid, fallback }

class RedirectVerificationResult {
  const RedirectVerificationResult({
    required this.status,
    required this.message,
  });

  const RedirectVerificationResult.verified({
    this.message =
        'Email verified, now you may login to your account with your credentials',
  }) : status = RedirectVerificationStatus.verified;

  const RedirectVerificationResult.expired({required this.message})
    : status = RedirectVerificationStatus.expired;

  const RedirectVerificationResult.invalid({required this.message})
    : status = RedirectVerificationStatus.invalid;

  const RedirectVerificationResult.fallback({required this.message})
    : status = RedirectVerificationStatus.fallback;

  final RedirectVerificationStatus status;
  final String message;
}
