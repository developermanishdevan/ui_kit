class AppValidators {
  AppValidators._();

  // ─── Required ──────────────────────────────────────────────
  static String? required(String? value,
      {String message = 'This field is required.'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  // ─── Email ─────────────────────────────────────────────────
  static String? email(String? value,
      {String message = 'Enter a valid email address.'}) {
    if (value == null || value.trim().isEmpty) {
      return null; // use with required()
    }
    final re = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false);
    return re.hasMatch(value.trim()) ? null : message;
  }

  // ─── Password ──────────────────────────────────────────────
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = false,
    bool requireNumber = true,
    bool requireSpecial = false,
    String? message,
  }) {
    if (value == null || value.isEmpty) return null;
    if (value.length < minLength) {
      return message ?? 'Password must be at least $minLength characters.';
    }
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter.';
    }
    if (requireNumber && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number.';
    }
    if (requireSpecial && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain a special character.';
    }
    return null;
  }

  // ─── Password Confirm ──────────────────────────────────────
  static String? Function(String?) confirmPassword(String? original) {
    return (value) {
      if (value != original) return 'Passwords do not match.';
      return null;
    };
  }

  // ─── Phone ─────────────────────────────────────────────────
  static String? phone(String? value,
      {String message = 'Enter a valid phone number.'}) {
    if (value == null || value.trim().isEmpty) return null;
    final re = RegExp(r'^\+?[0-9]{7,15}$');
    return re.hasMatch(value.trim().replaceAll(RegExp(r'[\s\-()]'), ''))
        ? null
        : message;
  }

  // ─── URL ───────────────────────────────────────────────────
  static String? url(String? value, {String message = 'Enter a valid URL.'}) {
    if (value == null || value.trim().isEmpty) return null;
    final uri = Uri.tryParse(value.trim());
    return (uri != null && (uri.isScheme('http') || uri.isScheme('https')))
        ? null
        : message;
  }

  // ─── Min / Max Length ──────────────────────────────────────
  static String? Function(String?) minLength(int min, {String? message}) {
    return (value) {
      if (value == null || value.length >= min) return null;
      return message ?? 'Minimum $min characters required.';
    };
  }

  static String? Function(String?) maxLength(int max, {String? message}) {
    return (value) {
      if (value == null || value.length <= max) return null;
      return message ?? 'Maximum $max characters allowed.';
    };
  }

  // ─── Numeric Range ─────────────────────────────────────────
  static String? Function(String?) numericRange(double min, double max,
      {String? message}) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      final n = double.tryParse(value);
      if (n == null) return 'Enter a valid number.';
      if (n < min || n > max) {
        return message ?? 'Value must be between $min and $max.';
      }
      return null;
    };
  }

  // ─── Compose validators ────────────────────────────────────
  /// Runs multiple validators in sequence. Returns first non-null error.
  static String? Function(String?) compose(
      List<String? Function(String?)> validators) {
    return (value) {
      for (final v in validators) {
        final error = v(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
