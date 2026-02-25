import 'package:flutter/material.dart';
import '../dropdown/app_dropdown.dart';

class AppAsyncDropdown<T> extends StatefulWidget {
  const AppAsyncDropdown({
    required this.future, required this.value, required this.onChanged, super.key,
    this.label,
    this.hint,
    this.loadingHint = 'Loading items...',
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
  });

  final Future<List<AppDropdownItem<T>>> future;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hint;
  final String loadingHint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(T?)? validator;

  @override
  State<AppAsyncDropdown<T>> createState() => _AppAsyncDropdownState<T>();
}

class _AppAsyncDropdownState<T> extends State<AppAsyncDropdown<T>> {
  List<AppDropdownItem<T>>? _items;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await widget.future;
      if (mounted) setState(() => _items = items);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return AppDropdown<T>(
        items: const [],
        value: null,
        onChanged: (_) {},
        label: widget.label,
        hint: widget.loadingHint,
        enabled: false,
        prefixIcon: widget.prefixIcon,
      );
    }

    if (_error != null) {
      return AppDropdown<T>(
        items: const [],
        value: null,
        onChanged: (_) {},
        label: widget.label,
        hint: 'Error loading items',
        errorText: _error,
        enabled: false,
        prefixIcon: widget.prefixIcon,
      );
    }

    return AppDropdown<T>(
      items: _items ?? [],
      value: widget.value,
      onChanged: widget.onChanged,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      helperText: widget.helperText,
      prefixIcon: widget.prefixIcon,
      enabled: widget.enabled,
      validator: widget.validator,
    );
  }
}
