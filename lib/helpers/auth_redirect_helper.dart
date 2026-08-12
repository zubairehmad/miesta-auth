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

bool isThereRedirectError(Map<String, String> parameters) {
  final rawError =
      parameters['error_description'] ??
      parameters['error'] ??
      parameters['error_code'];

  return (rawError != null && rawError.trim().isNotEmpty);
}

String getLastPath(String path) {
  var normalized = path.trim();
  if (normalized.isEmpty) return "";
  int i = normalized.length - 1;
  while (i >= 0 && normalized[i] == '/') {
    --i;
  }
  normalized = normalized.substring(0, i + 1);
  return "/${normalized.split('/').last}";
}
