import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get light => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  ThemeData get dark => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
