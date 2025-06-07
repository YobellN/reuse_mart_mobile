import 'package:reuse_mart_mobile/models/detail_penitipan.dart';
import 'package:reuse_mart_mobile/models/foto_produk.dart';
import 'package:reuse_mart_mobile/models/kategori.dart';

class Produk {
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

  Produk({
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
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      idProduk: json['id_produk'],
      idKategori: json['id_kategori'].toString(),
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: json['harga_produk'],
      statusAkhirProduk: json['status_akhir_produk'],
      statusKetersediaan: json['status_ketersediaan'],
      waktuGaransi: json['waktu_garansi'],
      statusProdukHunting: json['status_produk_hunting'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      kategori: Kategori.fromJson(json['kategori']),
      detailPenitipan: DetailPenitipan.fromJson(json['detail_penitipan']),
      fotoProduk: (json['foto_produk'] as List)
          .map((e) => FotoProduk.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'id_kategori': idKategori,
      'nama_produk': namaProduk,
      'deskripsi_produk': deskripsiProduk,
      'harga_produk': hargaProduk,
      'status_akhir_produk': statusAkhirProduk,
      'status_ketersediaan': statusKetersediaan,
      'waktu_garansi': waktuGaransi,
      'status_produk_hunting': statusProdukHunting,
      'rating': rating,
      'kategori': kategori.toJson(),
      'foto_produk': fotoProduk.map((e) => e.toJson()).toList(),
    };
  }
}









