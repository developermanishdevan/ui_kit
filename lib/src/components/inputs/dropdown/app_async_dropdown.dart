import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A dropdown component that loads its options asynchronously.
class AppAsyncDropdown<T> extends AppStatefulWrapper {
  final Future<List<AppDropdownOption<T>>> future;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? labelText;
  final String? hintText;
  final String loadingText;
  final String errorText;
  final Widget? prefixIcon;
  final bool enabled;

  const AppAsyncDropdown({
    super.key,
    required this.future,
    required this.value,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.loadingText = 'Loading options...',
    this.errorText = 'Failed to load options',
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  State<AppAsyncDropdown<T>> createState() => _AppAsyncDropdownState<T>();
}

class _AppAsyncDropdownState<T>
    extends AppStatefulWrapperState<AppAsyncDropdown<T>> {
  List<AppDropdownOption<T>>? _options;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final options = await widget.future;
      if (mounted) {
        setState(() {
          _options = options;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = widget.errorText;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (_isLoading) {
      return AppDropdown<T>(
        labelText: widget.labelText,
        hintText: widget.loadingText,
        options: const [],
        value: null,
        onChanged: (_) {},
        enabled: false,
        prefixIcon:
            widget.prefixIcon ??
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
      );
    }

    if (_errorMessage != null) {
      return AppDropdown<T>(
        labelText: widget.labelText,
        hintText: _errorMessage,
        options: const [],
        value: null,
        onChanged: (_) {},
        enabled: false,
        prefixIcon: const Icon(Icons.error_outline, color: Colors.red),
      );
    }

    return AppDropdown<T>(
      labelText: widget.labelText,
      hintText: widget.hintText,
      options: _options ?? [],
      value: widget.value,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      prefixIcon: widget.prefixIcon,
    );
  }
}
