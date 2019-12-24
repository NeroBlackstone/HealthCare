class InputValidator {
  static String inputUsernameValidate(String value) {
    if (value.isEmpty)
      return 'Please enter username';
    else
      return null;
  }

  static String inputPasswordValidate(String value) {
    if (value.isEmpty)
      return 'Please enter password';
    else
      return null;
  }
}
