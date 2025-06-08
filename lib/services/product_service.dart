import 'dart:convert';
import 'package:reuse_mart_mobile/models/produk_titipan.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/models/produk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  static Future<List<Produk>> fetchProducts({int page = 1, int limit = 6, String? kategori, String? search}) async {
    try {
      String url = 'produk?page=$page&limit=$limit';
      if (kategori != null && kategori.isNotEmpty) {
        url += '&kategori=$kategori';
      }
      if (search != null && search.isNotEmpty) {
        url += '&search=$search';
      }
      final response = await Api.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('data') && jsonBody['data'] is Map && jsonBody['data']['data'] is List) {
          if(page == 1) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('cached_produk', json.encode(jsonBody['data']['data']));
          }
          final List<dynamic> dataList = jsonBody['data']['data'];
          return dataList.map((e) => Produk.fromJson(e)).toList();
        } else {
          throw Exception('Invalid JSON structure: ${jsonBody.toString()}');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<Produk>> fetchProductsPenitip(String idPenitip) async {
    try {
      String url = 'get-produk-by-penitip/$idPenitip';
      final response = await Api.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('data')) {
          final List<dynamic> dataList = jsonBody['data'];
          return dataList.map((e) => Produk.fromJson(e)).toList();
        } else {
          throw Exception('Invalid JSON structure: ${jsonBody.toString()}');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }


  static Future<List<ProdukTitipan>> fetchProdukTitipanPenitip({
    String? statusProduk,
  }) async {
    try {
      final response = await Api.getWithAuth(
        'penitip/penitipan/produk-titipan',
        params: statusProduk != null ? {'status_produk': statusProduk} : null,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('data') && jsonBody['data'] is List) {
          return (jsonBody['data'] as List)
              .map((item) => ProdukTitipan.fromJson(item))
              .toList();
        } else {
          throw Exception('Invalid JSON structure: ${jsonBody.toString()}');
        }
      } else {
        throw Exception(
          'Failed to load produk titipan: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

}
