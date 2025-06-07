import 'package:reuse_mart_mobile/models/merchandise.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class MerchService {
  static Future<List<Merchandise>> fetchMerchandise() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) return [];
      final response = await Api.get(
        'merchandise',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if (jsonBody.containsKey('data')) {
          final List<dynamic> dataList = jsonBody['data'];
          return dataList.map((e) => Merchandise.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<String> klaimMerchandise(int idMerchandise) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) return '';

      final response = await Api.post(
        'transaksi-merchandise/$idMerchandise',
        {},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['message'];
      }
      return json.decode(response.body)['message'];
    } catch (e) {
      developer.log('klaimMerchandise error', error: e);
      try {
        return json.decode(e.toString())['message'];
      } catch (_) {
        return 'An error occurred.';
      }
    }
  }
}
