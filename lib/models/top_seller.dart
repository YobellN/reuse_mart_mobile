import 'package:reuse_mart_mobile/models/penitip_detail.dart';

class TopSeller {
  final int idTopSeller;
  final String idPenitip;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final double totalPenjualan;
  final double bonus;
  final double? avgRating;
  final int totalProduk;
  final PenitipDetail penitip;

  TopSeller({
    required this.idTopSeller,
    required this.idPenitip,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.totalPenjualan,
    required this.bonus,
    required this.avgRating,
    required this.totalProduk,
    required this.penitip,
  });

  factory TopSeller.fromJson(Map<String, dynamic> json) {
    return TopSeller(
      idTopSeller: json['id_top_seller'],
      idPenitip: json['id_penitip'],
      tanggalMulai: DateTime.parse(json['tanggal_mulai']),
      tanggalSelesai: DateTime.parse(json['tanggal_selesai']),
      totalPenjualan: double.parse(json['total_penjualan']),
      bonus: double.parse(json['bonus']),
      avgRating:
          json['avg_rating'] != null
              ? (json['avg_rating'] as num).toDouble()
              : null,
      totalProduk: json['total_produk'],
      penitip: PenitipDetail.fromJson(json['penitip']),
    );
  }
}
