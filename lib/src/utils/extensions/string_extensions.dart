extension StringExtensions on String {
  // Casing
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');
  String get camelCase {
    final words = split(RegExp(r'[\s_-]+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join();
  }

  String get snakeCase =>
      replaceAllMapped(RegExp(r'([A-Z])'), (m) => '_${m[0]!.toLowerCase()}')
          .toLowerCase();
  String get kebabCase => snakeCase.replaceAll('_', '-');

  // Validation
  bool get isEmail =>
      RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false)
          .hasMatch(this);
  bool get isUrl => Uri.tryParse(this)?.hasScheme ?? false;
  bool get isNumeric => double.tryParse(this) != null;
  bool get isBlank => trim().isEmpty;
  bool get isNotBlank => !isBlank;

  // Manipulation
  String get removeWhitespace => replaceAll(RegExp(r'\s'), '');
  String truncateStr(int max, {String ellipsis = '...'}) =>
      length <= max ? this : '${substring(0, max - ellipsis.length)}$ellipsis';
  String repeat(int times) => List.filled(times, this).join();

  // Type conversions
  int get toIntOrZero => int.tryParse(this) ?? 0;
  double get toDoubleOrZero => double.tryParse(this) ?? 0.0;
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
  String get orEmpty => this ?? '';
}
