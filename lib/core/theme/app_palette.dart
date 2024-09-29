import 'package:flutter/material.dart';

class AppPalette {
  static DarkPalette dark = DarkPalette();
}

class DarkPalette {
  DarkPalette();

  Color primary = const Color.fromARGB(255, 3, 3, 3);
  Color primaryContainer = const Color.fromRGBO(47, 65, 86, 1.0);
  Color onPrimaryContainer = const Color.fromRGBO(215, 226, 255, 1.0);
  Color primarySurface = const Color.fromRGBO(19, 35, 44, 1.0);
  Color secondarySurface = const Color.fromRGBO(30, 42, 50, 1.0);
  Color background = const Color.fromRGBO(14, 24, 30, 1.0);
  Color onSurface20 = const Color.fromRGBO(224, 241, 255, 1.0);
  Color onSurface40 = const Color.fromRGBO(191, 198, 218, 1.0);
  Color onSurface60 = const Color.fromRGBO(168, 173, 189, 1.0);
}

class LightPalette {
  LightPalette();

  Color primary = const Color.fromRGBO(27, 114, 192, 1.0);
  Color primaryContainer = const Color.fromRGBO(211, 228, 255, 1.0);
  Color onPrimaryContainer = const Color.fromRGBO(0, 28, 56, 1.0);
  Color primarySurface = const Color.fromRGBO(243, 244, 249, 1.0);
  Color secondarySurface = const Color.fromRGBO(239, 241, 248, 1.0);
  Color background = const Color.fromRGBO(252, 252, 255, 1.0);
  Color onSurface20 = const Color.fromRGBO(0, 30, 47, 1.0);
  Color onSurface40 = const Color.fromRGBO(68, 71, 78, 1.0);
  Color onSurface60 = const Color.fromRGBO(116, 119, 127, 1.0);
}
