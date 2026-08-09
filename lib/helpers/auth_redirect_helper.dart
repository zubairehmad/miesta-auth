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

String? extractRedirectErrorMessage(Map<String, String> parameters) {
  final rawError =
      parameters['error_description'] ??
      parameters['error'] ??
      parameters['error_code'];
  if (rawError == null || rawError.trim().isEmpty) {
    return null;
  }

  return Uri.decodeComponent(rawError.replaceAll('+', ' ')).trim();
}

bool isVerifyEmailPath(String path) {
  var normalized = path.trim();
  if (normalized.isEmpty) {
    return false;
  }

  while (normalized.length > 1 && normalized.endsWith('/')) {
    normalized = normalized.substring(0, normalized.length - 1);
  }

  return normalized == '/verify-email' || normalized.endsWith('/verify-email');
}

String buildRedirectFallbackMessage(Map<String, String> parameters) {
  final parameterNames = parameters.keys.take(4).join(', ');
  if (parameterNames.isEmpty) {
    return 'No verification data was found in this redirect.';
  }

  return 'A redirect was received with parameters: $parameterNames.';
}
