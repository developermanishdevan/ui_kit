extension AppStringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalizes the first letter of every word.
  String capitalizeAll() {
    if (isEmpty) return this;
    return split(' ').map((e) => e.capitalize()).join(' ');
  }

  /// Checks if the string is a valid email.
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}
