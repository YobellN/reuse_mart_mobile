import 'package:reuse_mart_mobile/models/User.dart';

class Penitip {
  final String idPenitip;
  final int idUser;
  final String nik;
  final String fotoKtp;
  final int saldo;
  final int poin;
  final User user;
  final double? rating;

  Penitip({
    required this.idPenitip,
    required this.idUser,
    required this.nik,
    required this.fotoKtp,
    required this.saldo,
    required this.poin,
    required this.user,
    required this.rating,
  });

  factory Penitip.fromJson(Map<String, dynamic> json) {
    return Penitip(
      idPenitip: json['id_penitip'],
      idUser: json['id_user'],
      nik: json['nik'],
      fotoKtp: json['foto_ktp'],
      saldo: json['saldo'],
      poin: json['poin'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      user: User.fromJson(json['user']),
    );
  }
}
