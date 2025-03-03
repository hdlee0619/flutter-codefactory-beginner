import 'package:flutter/material.dart';
import 'package:row_column_padding/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                colors
                    .map(
                      (color) =>
                          Container(height: 50.0, width: 50.0, color: color),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
