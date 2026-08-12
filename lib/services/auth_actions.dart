import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthActions {
  AuthActions._();

  static final _auth = Supabase.instance.client.auth;

  static bool get hasSession => _auth.currentSession != null;

  /// Converts supabase error codes into normalized error codes that match public api documentation
  static String _normalizeErrorCode(String? errorCode) {
    switch (errorCode) {
      case "over_request_rate_limit":
      case "over_email_send_rate_limit":
      case "over_sms_send_rate_limit":
      case "conflict":
        return "too-many-requests";

      case "request_timeout":
      case "hook_timeout":
      case "hook_timeout_after_retry":
        return "network-request-failed";

      case "signup_disabled":
      case "email_provider_disabled":
      case "phone_provider_disabled":
      case "provider_disabled":
      case "oauth_provider_not_supported":
      case "otp_disabled":
      case "manual_linking_disabled":
      case "anonymous_provider_disabled":
        return "operation-not-allowed";

      case "session_expired":
      case "session_not_found":
      case "refresh_token_not_found":
      case "refresh_token_already_used":
        return "user-token-expired";

      case "user_banned":
        return "user-disabled";
      case "weak_password":
        return "weak-password";
      case "same_password":
        return "same-password";
      default:
        return "unknown-error";
    }
  }

  static Future<String?> _wrapInTryCatch(
    Function func,
    String? funcName,
  ) async {
    try {
      await func();
    } on AuthApiException catch (e) {
      return _normalizeErrorCode(e.code);
    } catch (e) {
      funcName ??= '[FUNC_NAME_NOT_GIVEN]';
      debugPrint(
        'Unexpected exception caugth in AuthActions.$funcName : ${e.toString()}',
      );
      return 'unknown-error';
    }
    return null;
  }

  /// Updates the password of the user (which is currently logged in), on success it returns `null`.
  ///
  /// In case of error, the error code is returned as string:
  ///
  /// - **"weak-password":** Returned if the new password chosen is very weak.
  /// - **"same-password":** Returned if the new password chosen is the current password.
  /// - **"user-token-expired":** Returned if the access token of the logged in user expired.
  /// - **"no-user-present":** Returned if no user is currently logged in.
  /// - **"network-request-failed":** Returned if there was a network request error, for example the user doesn't have internet connection.
  /// - **"unknown-error":** Returned if an unexpected error occurs.
  static Future<String?> updatePassword(String newPassword) => _wrapInTryCatch(
    () async {
      if (_auth.currentUser == null) return 'no-user-present';
      await _auth.updateUser(
        UserAttributes(password: newPassword),
      );
    },
    'updatePassword',
  );

  static Future<void> signOut() => _auth.signOut();
}
