//NOTE: ini pakai model baru khusus untuk data di profil. kalo pake model biasa susah karna
//pas login gak nyimpan id penitip

import 'package:reuse_mart_mobile/models/User.dart';
import 'package:reuse_mart_mobile/models/penitip_raw.dart';

class PenitipProfile {
  final User user;
  final PenitipRaw penitip;

  PenitipProfile({required this.user, required this.penitip});

  factory PenitipProfile.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('penitip')) {
      throw Exception("Key 'penitip' tidak ditemukan dalam response");
    }

    return PenitipProfile(
      user: User.fromJson({
        'nama': json['nama'] ?? '',
        'email': json['email'] ?? '',
        'no_telp': json['no_telp'] ?? '',
        'role': json['role'] ?? '',
        'fcm_token': json['fcm_token'],
      }),
      penitip: PenitipRaw.fromJson(json['penitip']),
    );
  }
}
