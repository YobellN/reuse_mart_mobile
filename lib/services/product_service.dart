import 'dart:convert';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/models/produk.dart';

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

        if (jsonBody.containsKey('data') &&
            jsonBody['data'] is Map &&
            jsonBody['data']['data'] is List) {
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
}
