import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Todo',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(255, 0, 171, 157),
        fontSize: 90,
        fontFamily: 'ShadowsIntoLight',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
