import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reuse_mart_mobile/services/globals.dart';

class AuthService {
  static Future<http.Response> Login(String email, String password) async {
    Map data = {'email': email, 'password': password};
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}loginMobile');
    http.Response response = await http.post(url, headers: headers, body: body);
    return response;
  }
}
