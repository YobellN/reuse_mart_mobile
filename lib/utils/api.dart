import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; 
  static const String storageUrl = 'http://10.0.2.2:8000/storage/';

  static Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: params?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
    return await http.get(uri, headers: headers).timeout(Duration(seconds: 30));
  }

  static Future<http.Response> getWithAuth(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: params?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final combinedHeaders = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      ...?headers,
    };

    return await http.get(uri, headers: combinedHeaders);
  }


  static Future<http.Response> post(String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url, body: data, headers: headers);
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.put(url, body: data, headers: headers);
  }

  static Future<http.Response> patch(String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.patch(url, body: data, headers: headers);
  }

  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.delete(url, headers: headers);
  }
}