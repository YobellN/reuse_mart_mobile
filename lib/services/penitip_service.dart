import 'dart:convert';
import 'package:reuse_mart_mobile/models/penitip.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenitipService {
  static const _cacheKey = 'cached_penitip';

  static Future<Penitip?> fetchPenitipById(String idPenitip) async {
    try {
      String url = 'penitip/$idPenitip';
      final response = await Api.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('data')) {
          return Penitip.fromJson(jsonBody['data']);
        } else {
          throw Exception('Invalid JSON structure: ${jsonBody.toString()}');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Penitip?> getCachedPenitip() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      return Penitip.fromJson(json.decode(cached));
    }
    return null;
  }

  static Future<Penitip?> fetchPenitip() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return null;

      final response = await Api.get(
        'penitip/get-penitip',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if(jsonBody.containsKey('data')) {
          final Map<String, dynamic> data = jsonBody['data'] as Map<String, dynamic>;
          final penitip = Penitip.fromJson(data);
          prefs.setString('cached_penitip', json.encode(data));
          return penitip;
        }
        return null;
      }
    } catch (e) {
      print('Error fetching penitip: $e');
    }
    return null;
  }


}