import 'dart:convert';
import 'package:reuse_mart_mobile/models/pembeli.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembeliService {
  static const _cacheKey = 'cached_pembeli';

  static Future<Pembeli?> getCachedPembeli() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      return Pembeli.fromJson(json.decode(cached));
    }
    return null;
  }

  static Future<Pembeli?> getPembeli() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) return null;

      final response = await Api.get(
        'getUser',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final data = jsonBody['data'];
        if (data == null) return null;

        final pembeli = Pembeli.fromJson(data);
        prefs.setString(_cacheKey, json.encode(data));
        return pembeli;
      }
    } catch (e) {
      print('Error fetching pembeli: $e');
    }
    return null;
  }
}
