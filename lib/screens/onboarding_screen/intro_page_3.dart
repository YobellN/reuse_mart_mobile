import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Join the Movement',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
