import 'dart:convert';

import 'package:reuse_mart_mobile/models/pegawai.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HunterService {
  static Future<Pegawai?> getHunter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return null;

      final response = await Api.get(
        'hunter/get-pegawai',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if (jsonBody.containsKey('data')) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('cached_hunter', json.encode(jsonBody['data']));
          return Pegawai.fromJson(jsonBody['data']);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
