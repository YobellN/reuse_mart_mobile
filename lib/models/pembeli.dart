import 'package:reuse_mart_mobile/models/User.dart';
import 'package:reuse_mart_mobile/models/pembeli_raw.dart';

class Pembeli {
  final User user;
  final PembeliRaw pembeli;

  Pembeli({required this.user, required this.pembeli});

  factory Pembeli.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('pembeli')) {
      throw Exception("Key 'pembeli' tidak ditemukan dalam response");
    }

    return Pembeli(
      user: User.fromJson(json),
      pembeli: PembeliRaw.fromJson(json['pembeli']),
    );
  }
}
