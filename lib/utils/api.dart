import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; 
  static const String storageUrl = 'http://10.0.2.2:8000/storage/';

  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url, body: data, headers: headers);
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.put(url, body: data, headers: headers);
  }

  static Future<http.Response> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.delete(url, headers: headers);
  }
}