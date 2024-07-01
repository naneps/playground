import 'package:flutter/material.dart';
import 'package:playground/app/common/theme.dart';

enum TypeButton { primary, secondary, tertiary, danger, warning, success, none }

extension TypeButtonExtension on TypeButton {
  Color get color {
    switch (this) {
      case TypeButton.primary:
        return ThemeApp().primaryColor;
      case TypeButton.secondary:
        return ThemeApp().secondaryColor;
      case TypeButton.tertiary:
        return ThemeApp().tertiaryColor;
      case TypeButton.danger:
        return ThemeApp().errorColor;
      case TypeButton.warning:
        return ThemeApp().warningColor;
      case TypeButton.success:
        return ThemeApp().successColor;
      case TypeButton.none:
        return Colors.transparent;
    }
  }
}
