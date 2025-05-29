import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reuse_mart_mobile/Components/loginPageComponent/button-login.dart';
import 'package:reuse_mart_mobile/Components/loginPageComponent/input-login.dart';
import 'package:reuse_mart_mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void errorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // loginUserPressed -> Untuk login
  void loginUserPressed() async {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailController.text);
    bool passwordValid =
        passwordController.text.length >= 5; // karena pass nya 12345

    if (!emailValid || !passwordValid) {
      if (!emailValid) {
        errorSnackBar(context, "Email is not valid");
      }
      if (!passwordValid) {
        errorSnackBar(context, "Password is nota valid");
      }
    } else {
      http.Response response = await AuthService.Login(
        emailController.text,
        passwordController.text,
      );
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final data = responseMap['data'];

        await prefs.setString('token', data['access_token']);
        await prefs.setString('nama', data['user']['nama']);
        await prefs.setString('role', data['user']['role']);

        // Pindah ke halaman sesuai role: Pembeli, Penitip, Kurir, Hunter
        String role = data['user']['role'];
        if (mounted) {
          if (role == 'Penitip') {
            Navigator.pushReplacementNamed(context, '/penitipHome');
          } else if (role == 'Pembeli') {
            Navigator.pushReplacementNamed(context, '/pembeliHome');
          } else if (role == 'Kurir') {
            Navigator.pushReplacementNamed(context, '/kurirHome');
          } else if (role == 'Hunter') {
            Navigator.pushReplacementNamed(context, '/hunterHome');
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              // logo reusemart nanti
              Icon(Icons.lock, size: 100),

              SizedBox(height: 50),
              // Selaamt Datang!
              Text(
                'Selamat Datang!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),

              SizedBox(height: 25),
              // Email field
              InputLoginForm(
                controller: emailController,
                hintText: 'YourMail@mail.com',
                obsecureText: false,
              ),

              SizedBox(height: 25),
              // Password field
              InputLoginForm(
                controller: passwordController,
                hintText: 'Password',
                obsecureText: true,
              ),

              SizedBox(height: 25),
              // Login button
              ButtonLogin(onTap: loginUserPressed),
            ],
          ),
        ),
      ),
    );
  }
}
