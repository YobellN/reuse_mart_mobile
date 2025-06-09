import 'dart:convert';

import 'package:reuse_mart_mobile/models/pegawai.dart';
import 'package:reuse_mart_mobile/models/kurir.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class KurirService {
  static Future<Pegawai?> getKurir() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return null;

      final response = await Api.get(
        'kurir/get-pegawai',
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
          prefs.setString('cached_kurir', json.encode(jsonBody['data']));
          return Pegawai.fromJson(jsonBody['data']);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<PengirimanKurir>> getRiwayatPengiriman() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return [];

      final response = await Api.get(
        'kurir/getPengirimanKurir',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if (jsonBody.containsKey('data')) {
          final List<dynamic> pengirimanList = jsonBody['data'];
          return pengirimanList
              .map((json) => PengirimanKurir.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<String> updateStatusPengiriman(String idPenjualan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return '';

      final response = await Api.post(
        'kurir/konfirmasiSelesaiPengiriman/$idPenjualan',
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
