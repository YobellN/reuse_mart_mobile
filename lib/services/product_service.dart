import 'dart:convert';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/models/produk.dart';

class ProductService {
  static Future<List<Produk>> fetchProducts(int page, int limit) async {
    try {
      final response = await Api.get('produk?page=$page&limit=$limit');

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
}
