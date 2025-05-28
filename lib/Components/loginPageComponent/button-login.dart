import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  final Function()? onTap;
  const ButtonLogin({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: Colors.green[400], borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Center(child: Text("Login", style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,
          ),)),
        ),
      ),
    );
  }
}