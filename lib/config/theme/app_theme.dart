import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    const marvelColor = Color(0xFFF0131E);

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: marvelColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
