import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80.0,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'sunflower',
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'sunflower',
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'sunflower',
            fontSize: 20.0,
          ),
        ),
      ),
    ),
  );
}
