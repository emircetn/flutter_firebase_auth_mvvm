import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.orange,
      fontFamily: 'Oxygen',
      accentColor: Colors.purple[600],
      textTheme: TextTheme(
          overline: TextStyle(fontSize: 12),
          headline2: TextStyle(color: Colors.purple[400])),
      canvasColor: Colors.white);
}
