import 'package:flutter/material.dart';

/// Extension methods for Color to provide better opacity handling
extension ColorExtensions on Color {
  /// Creates a copy of this color with the given opacity value.
  /// Uses integer alpha values to avoid precision loss that can occur with opacity
  ///
  /// The [opacity] parameter must be between 0.0 and 1.0, inclusive.
  Color withPreciseOpacity(double opacity) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'opacity must be between 0.0 and 1.0',
    );
    return withAlpha((opacity * 255).round());
  }
}
