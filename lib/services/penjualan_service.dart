import 'dart:convert';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reuse_mart_mobile/utils/api.dart';

class PenjualanService {
  static Future<List<Penjualan>> getPenjualanPembeli({
    String? status,
    String? metodePengiriman,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) throw Exception('Token not found');

      final response = await Api.get(
        'penjualan',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        params: {
          if (status != null) 'status_penjualan': status,
          if (metodePengiriman != null) 'metode_pengiriman': metodePengiriman,
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['data'];
        return data.map((item) => Penjualan.fromJson(item)).toList();
      } else {
        print('Failed to fetch penjualan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching penjualan: $e');
    }
    return [];
  }
}
