import 'package:reuse_mart_mobile/models/Penitipan.dart';

class DetailPenitipan {
  final String idPenitipan;
  final String idProduk;
  final String? tanggalPengambilan;
  final int konfirmasiDonasi;
  final Penitipan penitipan;

  DetailPenitipan({
    required this.idPenitipan,
    required this.idProduk,
    required this.tanggalPengambilan,
    required this.konfirmasiDonasi,
    required this.penitipan,
  });

  factory DetailPenitipan.fromJson(Map<String, dynamic> json) {
    return DetailPenitipan(
      idPenitipan: json['id_penitipan'],
      idProduk: json['id_produk'],
      tanggalPengambilan: json['tanggal_pengambilan'],
      konfirmasiDonasi: json['konfirmasi_donasi'],
      penitipan: Penitipan.fromJson(json['penitipan']),
    );
  }
}