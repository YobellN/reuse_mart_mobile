import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/pages/loginPages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenitipHomePage extends StatelessWidget {
  const PenitipHomePage({super.key});
  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        const Center(child: Text("Penitip Home Page")),
        TextButton(onPressed: () => logout(context), child: const Text("Logout")),
      ],
    ));
  }
}
