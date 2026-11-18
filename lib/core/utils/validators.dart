class AppValidators {
  AppValidators._();

  static String? validateQrInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter text or a URL';
    }

    if (value.trim().length > 2000) {
      return 'Input is too long';
    }

    return null;
  }
}
