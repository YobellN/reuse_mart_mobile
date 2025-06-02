import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Welcome to ReuseMart',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
