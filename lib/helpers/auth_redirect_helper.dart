Map<String, String> collectRedirectParameters(Uri uri) {
  final parameters = <String, String>{};
  parameters.addAll(uri.queryParameters);

  final fragment = uri.fragment.trim();
  if (fragment.isNotEmpty) {
    final fragmentQuery = fragment.startsWith('?')
        ? fragment.substring(1)
        : fragment;
    if (fragmentQuery.contains('=')) {
      parameters.addAll(Uri.splitQueryString(fragmentQuery));
    }
  }

  return parameters;
}

String? extractSupabaseErrorMessage(Map<String, String> parameters) {
  final rawError =
      parameters['error_description'] ??
      parameters['error'] ??
      parameters['error_code'];
  if (rawError == null || rawError.trim().isEmpty) {
    return null;
  }

  return Uri.decodeComponent(rawError.replaceAll('+', ' ')).trim();
}

bool isLikelyExpiredError(String message) {
  final normalized = message.toLowerCase();
  return normalized.contains('expired') ||
      normalized.contains('otp_expired') ||
      normalized.contains('token has expired') ||
      normalized.contains('invalid grant') ||
      normalized.contains('invalid_grant');
}

bool isEmailVerificationRedirect(Map<String, String> parameters) {
  final combined = parameters.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join('&')
      .toLowerCase();

  return combined.contains('email') &&
      (combined.contains('confirm') ||
          combined.contains('verification') ||
          combined.contains('verify') ||
          combined.contains('signup') ||
          combined.contains('invite'));
}

String buildRedirectFallbackMessage(Map<String, String> parameters) {
  final parameterNames = parameters.keys.take(4).join(', ');
  if (parameterNames.isEmpty) {
    return 'A redirect was received, but no usable parameters were found.';
  }

  return 'A redirect was received with parameters: $parameterNames.';
}
