import 'package:reuse_mart_mobile/models/komisi_hunter.dart';
import 'package:reuse_mart_mobile/models/produk.dart';

class   DetailPenjualan {
  int idDetailPenjualan;
  String idPenjualan;
  String idProduk;
  Produk? produk;
  KomisiHunter? komisi;

  DetailPenjualan({
    required this.idDetailPenjualan,
    required this.idPenjualan,
    required this.idProduk,
    required this.produk,
    required this.komisi,
  });

  factory DetailPenjualan.fromJson(Map<String, dynamic> json) {
    return DetailPenjualan(
      idDetailPenjualan: json['id_detail_penjualan'],
      idPenjualan: json['id_penjualan'],
      idProduk: json['id_produk'],
      produk: json['produk'] != null ? Produk.fromJson(json['produk']) : null,
      komisi: json['komisi'] != null ? KomisiHunter.fromJson(json['komisi']) : null,
    );
  }
}
