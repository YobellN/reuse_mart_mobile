import 'dart:convert';
import 'package:reuse_mart_mobile/models/top_seller.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopSellerService {
  static const _cacheKey = 'cached_top_seller';

  static Future<List<TopSeller>> fetchTopSellers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return [];

      final response = await Api.get(
        'top-seller',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final List<dynamic> dataList = jsonBody['data'];

        // simpan cache
        prefs.setString(_cacheKey, json.encode(dataList));

        return dataList.map((item) => TopSeller.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat top seller: ${response.statusCode}');
      }
    } catch (e) {
      print('TopSellerService error: $e');
      return [];
    }
  }

  static Future<List<TopSeller>> getCachedTopSellers() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      final List<dynamic> dataList = json.decode(cached);
      return dataList.map((item) => TopSeller.fromJson(item)).toList();
    }
    return [];
  }
}
