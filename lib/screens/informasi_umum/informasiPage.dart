import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformasiPage extends StatelessWidget {
  final String role;
  const InformasiPage({super.key, required this.role});
  
  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final displayRole = (role == '' ? 'Umum' : role);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Informasi Page $displayRole"),
          TextButton(onPressed: () => logout(context), child: const Text("Logout"))
        ],
      ),
    );
  }
}
