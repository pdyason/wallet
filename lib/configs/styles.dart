import 'package:flutter/material.dart';

class Styles {
  static const double iconSize = 30;
  static const double fontSize = 25;
  static const Color toolbarForegroundColor = Color.fromARGB(255, 228, 207, 185);
  static const Color toolbarShadowColor = Color.fromARGB(221, 43, 26, 8);
  static const Color listBackgroundColor = Color.fromARGB(255, 228, 207, 185);

  static const textStyle = TextStyle(
    fontSize: fontSize,
    color: toolbarForegroundColor,
    shadows: [Shadow(color: toolbarShadowColor, blurRadius: 10)],
  );
}
