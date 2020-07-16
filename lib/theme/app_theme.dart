import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get light => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        // platform: TargetPlatform.iOS,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  ThemeData get dark => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
          brightness: Brightness.light,
        ),
        brightness: Brightness.dark,
        // platform: TargetPlatform.iOS,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
