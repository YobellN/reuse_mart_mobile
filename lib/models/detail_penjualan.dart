import 'package:reuse_mart_mobile/models/produk.dart';

class DetailPenjualan {
  String idDetailPenjualan;
  String idPenjualan;
  String idProduk;
  Produk produk;

  DetailPenjualan({
    required this.idDetailPenjualan,
    required this.idPenjualan,
    required this.idProduk,
    required this.produk,
  });

  factory DetailPenjualan.fromJson(Map<String, dynamic> json) {
    return DetailPenjualan(
      idDetailPenjualan: json['id_detail_penjualan'],
      idPenjualan: json['id_penjualan'],
      idProduk: json['id_produk'],
      produk: Produk.fromJson(json['produk']),
    );
  }
}
