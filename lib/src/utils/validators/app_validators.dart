class AppValidators {
  AppValidators._();

  /// Validates if an email is formatted correctly.
  static String? email(
    String? value, {
    String error = 'Enter a valid email address',
  }) {
    if (value == null || value.isEmpty) return 'This field is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return error;
    return null;
  }

  /// Validates if a password meets criteria.
  static String? password(
    String? value, {
    int minLength = 8,
    String error = 'Password must be at least 8 characters',
  }) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < minLength) return error;
    return null;
  }

  /// Verifies a required field is not empty.
  static String? required(
    String? value, {
    String error = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) return error;
    return null;
  }
}
