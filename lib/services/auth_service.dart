import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reuse_mart_mobile/services/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<http.Response> login(
    String email,
    String password,
    String fcmToken,
  ) async {
    Map data = {'email': email, 'password': password, 'fcmToken': fcmToken};
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}loginMobile');
    http.Response response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await prefs.clear();

    if (fcmToken != null) {
      await prefs.setString('fcmToken', fcmToken);
    }

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
  }
}
