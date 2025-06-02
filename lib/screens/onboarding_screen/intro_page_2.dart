import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Discover Sustainable Products',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
