import 'package:flutter/material.dart';

extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;

  List<T> separatedBy(T separator) {
    if (isEmpty) return this;
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(separator);
    }
    return result;
  }

  List<List<T>> chunked(int size) {
    final result = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size).clamp(0, length)));
    }
    return result;
  }

  List<T> distinct() {
    final seen = <T>{};
    return where((e) => seen.add(e)).toList();
  }
}

extension NumExtensions on num {
  // Spacing helpers
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  // Range checks
  bool between(num min, num max) => this >= min && this <= max;
  num clamp01() => clamp(0, 1);

  // Duration
  Duration get ms => Duration(milliseconds: round());
  Duration get seconds => Duration(seconds: round());
  Duration get minutes => Duration(minutes: round());
}
