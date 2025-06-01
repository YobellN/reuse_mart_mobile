import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String? message;
  const NotificationScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Screen")),
      body: Center(child: Text(message ?? "", style: TextStyle(fontSize: 20))),
    );
  }
}
