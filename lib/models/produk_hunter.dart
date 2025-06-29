import 'package:reuse_mart_mobile/models/detail_penitipan.dart';
import 'package:reuse_mart_mobile/models/detail_penjualan.dart';
import 'package:reuse_mart_mobile/models/foto_produk.dart';
import 'package:reuse_mart_mobile/models/kategori.dart';

class ProdukHunter {
  final String idProduk;
  final String idKategori;
  final String namaProduk;
  final String deskripsiProduk;
  final int hargaProduk;
  final String? statusAkhirProduk;
  final bool statusKetersediaan;
  final String? waktuGaransi;
  final bool statusProdukHunting;
  final double? rating;
  final Kategori kategori;
  final DetailPenitipan detailPenitipan;
  final List<FotoProduk> fotoProduk;
  final DetailPenjualan? detailPenjualan;

  ProdukHunter({
    required this.idProduk,
    required this.idKategori,
    required this.namaProduk,
    required this.deskripsiProduk,
    required this.hargaProduk,
    required this.statusAkhirProduk,
    required this.statusKetersediaan,
    required this.waktuGaransi,
    required this.statusProdukHunting,
    required this.rating,
    required this.kategori,
    required this.detailPenitipan,
    required this.fotoProduk,
    required this.detailPenjualan
  });

  factory ProdukHunter.fromJson(Map<String, dynamic> json) {
    return ProdukHunter(
      idProduk: json['id_produk'],
      idKategori: json['id_kategori'].toString(),
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: json['harga_produk'],
      statusAkhirProduk: json['status_akhir_produk'],
      statusKetersediaan: json['status_ketersediaan'] ?? false,
      waktuGaransi: json['waktu_garansi'],
      statusProdukHunting: json['status_produk_hunting'],
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      kategori: Kategori.fromJson(json['kategori']),
      detailPenitipan: DetailPenitipan.fromJson(json['detail_penitipan']) ,
      fotoProduk:json['foto_produk'] != null ? (json['foto_produk'] as List).map((e) => FotoProduk.fromJson(e)).toList() : [],
      detailPenjualan: json['detail_penjualan'] != null ? DetailPenjualan.fromJson(json['detail_penjualan']) : null,
    );
  }
}
