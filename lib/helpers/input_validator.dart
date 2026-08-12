class InputValidator {
  InputValidator._();

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    } else if (value.length < 8) {
      return "Password must be atleast 8 letters long";
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    } else if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }
}
