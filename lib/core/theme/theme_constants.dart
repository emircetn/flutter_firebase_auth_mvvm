import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeConstants? _instace;
  static ThemeConstants get instance {
    _instace ??= ThemeConstants._init();
    return _instace!;
  }

  ThemeConstants._init();

  ThemeData lightTheme = ThemeData(
      primaryColor: Colors.orange,
      fontFamily: 'Oxygen',
      accentColor: Colors.purple[600],
      textTheme: TextTheme(overline: TextStyle(fontSize: 12), headline2: TextStyle(color: Colors.purple[400])),
      canvasColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: Colors.purple[600]),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
}
