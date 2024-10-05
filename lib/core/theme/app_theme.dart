import 'package:chat_app_flutter/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

// Định nghĩa extension cho ThemeData
extension CustomColors on ThemeData {
  Color get primary => brightness == Brightness.dark
      ? AppPalette.dark.primary
      : AppPalette.light.primary;

  Color get primaryContainer => brightness == Brightness.dark
      ? AppPalette.dark.primaryContainer
      : AppPalette.light.primaryContainer;

  Color get onPrimaryContainer => brightness == Brightness.dark
      ? AppPalette.dark.onPrimaryContainer
      : AppPalette.light.onPrimaryContainer;

  Color get primarySurface => brightness == Brightness.dark
      ? AppPalette.dark.primarySurface
      : AppPalette.light.primarySurface;

  Color get secondarySurface => brightness == Brightness.dark
      ? AppPalette.dark.secondarySurface
      : AppPalette.light.secondarySurface;

  Color get background => brightness == Brightness.dark
      ? AppPalette.dark.background
      : AppPalette.light.background;

  Color get onSurface20 => brightness == Brightness.dark
      ? AppPalette.dark.onSurface20
      : AppPalette.light.onSurface20;

  Color get onSurface40 => brightness == Brightness.dark
      ? AppPalette.dark.onSurface40
      : AppPalette.light.onSurface40;

  Color get onSurface60 => brightness == Brightness.dark
      ? AppPalette.dark.onSurface60
      : AppPalette.light.onSurface60;
}
