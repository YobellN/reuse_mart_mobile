import 'package:reuse_mart_mobile/models/detail_penjualan.dart';

class KomisiHunter {
  final int idDetailPenjualan;
  final String idPenitip;
  final String? idHunter;
  final double? komisiHunter;
  final DetailPenjualan? detailPenjualan;

  KomisiHunter({
    required this.idDetailPenjualan,
    required this.idPenitip,
    required this.idHunter,
    required this.komisiHunter,
    required this.detailPenjualan,
  });

  factory KomisiHunter.fromJson(Map<String, dynamic> json) {
    return KomisiHunter(
      idDetailPenjualan: json['id_detail_penjualan'],
      idPenitip: json['id_penitip'],
      idHunter: json['id_hunter'] ?? null,
      komisiHunter: json['komisi_hunter']?.toDouble(),
      detailPenjualan: json['detail_penjualan'] != null ? DetailPenjualan.fromJson(json['detail_penjualan']) : null,
    );
  }
}
