import 'dart:convert';
import 'package:reuse_mart_mobile/models/penitip.dart';
import 'package:reuse_mart_mobile/utils/api.dart';

class PenitipService {
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
}