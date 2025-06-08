import 'package:reuse_mart_mobile/models/User.dart';

class PenitipDetail {
  final String idPenitip;
  final int idUser;
  final String nik;
  final String fotoKtp;
  final int saldo;
  final int poin;
  final User user;
  final double? rating;
  final int? totalProduk;

  PenitipDetail({
    required this.idPenitip,
    required this.idUser,
    required this.nik,
    required this.fotoKtp,
    required this.saldo,
    required this.poin,
    required this.user,
    this.rating,
    this.totalProduk,
  });

  factory PenitipDetail.fromJson(Map<String, dynamic> json) {
    return PenitipDetail(
      idPenitip: json['id_penitip'] ?? '',
      idUser: json['id_user'] ?? 0,
      nik: json['nik'] ?? '',
      fotoKtp: json['foto_ktp'] ?? '',
      saldo: json['saldo'] ?? 0,
      poin: json['poin'] ?? 0,
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      totalProduk: json['total_produk'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}
