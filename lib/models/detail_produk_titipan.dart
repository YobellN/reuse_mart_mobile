import 'foto_produk.dart';
import 'kategori.dart';
import 'detail_penitipan.dart';

class DetailProdukTitipan {
  final String idProduk;
  final String namaProduk;
  final String deskripsiProduk;
  final int hargaProduk;
  final String? statusAkhirProduk;
  final bool statusKetersediaan;
  final String? waktuGaransi;
  final bool statusProdukHunting;
  final double? rating;
  final List<FotoProduk> fotoProduk;
  final Kategori kategori;
  final DetailPenitipan? detailPenitipan;

  DetailProdukTitipan({
    required this.idProduk,
    required this.namaProduk,
    required this.deskripsiProduk,
    required this.hargaProduk,
    required this.statusAkhirProduk,
    required this.statusKetersediaan,
    required this.waktuGaransi,
    required this.statusProdukHunting,
    required this.rating,
    required this.fotoProduk,
    required this.kategori,
    required this.detailPenitipan,
  });

  factory DetailProdukTitipan.fromJson(Map<String, dynamic> json) {
    return DetailProdukTitipan(
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: json['harga_produk'],
      statusAkhirProduk: json['status_akhir_produk'],
      statusKetersediaan: json['status_ketersediaan'],
      waktuGaransi: json['waktu_garansi'],
      statusProdukHunting: json['status_produk_hunting'],
      rating: json['rating']?.toDouble(),
      fotoProduk:
          (json['foto_produk'] as List)
              .map((e) => FotoProduk.fromJson(e))
              .toList(),
      kategori: Kategori.fromJson(json['kategori']),
      detailPenitipan:
          json['detail_penitipan'] != null
              ? DetailPenitipan.fromJson(json['detail_penitipan'])
              : null,
    );
  }
}
