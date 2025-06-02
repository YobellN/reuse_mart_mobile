import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reuse_mart_mobile/components/loginPageComponent/button-login.dart';
import 'package:reuse_mart_mobile/components/loginPageComponent/input-login.dart';
import 'package:reuse_mart_mobile/services/auth_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
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
      final prefs = await SharedPreferences.getInstance();
      http.Response response = await AuthService.login(
        emailController.text,
        passwordController.text,
        prefs.getString('fcmToken') ?? '',
      );
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = responseMap['data'];
        await prefs.setString('token', data['access_token']);
        await prefs.setString('nama', data['user']['nama']);
        await prefs.setString('role', data['user']['role']);

        // Pindah ke halaman sesuai role: Pembeli, Penitip, Kurir, Hunter
        String role = data['user']['role'];
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Logo container with shadow
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/icons/reuse-mart-icon.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 40),
                
                // Welcome text with styling
                Text(
                  'Selamat Datang!',
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),
                
                Text(
                  'Silakan masuk ke akun Anda',
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: 40),
                
                // Login form container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Change this from stretch to center
                    children: [
                      Center( // Add Center widget
                        child: Text(
                          'Login',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      InputLoginForm(
                        controller: emailController,
                        hintText: 'Email',
                        obsecureText: false,
                      ),
                      const SizedBox(height: 16),
                      InputLoginForm(
                        controller: passwordController,
                        hintText: 'Password',
                        obsecureText: true,
                      ),
                      const SizedBox(height: 24),
                      ButtonLogin(onTap: loginUserPressed),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
