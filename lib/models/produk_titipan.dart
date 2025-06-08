import 'package:reuse_mart_mobile/models/foto_produk.dart';
import 'package:reuse_mart_mobile/models/kategori.dart';
import 'package:reuse_mart_mobile/models/pegawai.dart';
import 'package:reuse_mart_mobile/models/penitip.dart';

class ProdukTitipan {
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
  final List<FotoProduk> fotoProduk;

  // diambil dari detail_penitipan
  final String idPenitipan;
  final String? tanggalPengambilan;
  final int konfirmasiDonasi;

  // diambil dari penitipan
  final String tanggalPenitipan;
  final String tenggatPenitipan;
  final String tenggatPengambilan;
  final int statusPerpanjangan;
  final Penitip penitip;
  final Pegawai qc;
  final Pegawai? hunter;

  ProdukTitipan({
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
    required this.fotoProduk,
    required this.idPenitipan,
    required this.tanggalPengambilan,
    required this.konfirmasiDonasi,
    required this.tanggalPenitipan,
    required this.tenggatPenitipan,
    required this.tenggatPengambilan,
    required this.statusPerpanjangan,
    required this.penitip,
    required this.qc,
    required this.hunter,
  });

  factory ProdukTitipan.fromJson(Map<String, dynamic> json) {
    final detailPenitipan = json['detail_penitipan'];
    final penitipan = detailPenitipan['penitipan'];

    return ProdukTitipan(
      idProduk: json['id_produk'],
      idKategori: json['id_kategori'].toString(),
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: json['harga_produk'],
      statusAkhirProduk: json['status_akhir_produk'],
      statusKetersediaan: json['status_ketersediaan'],
      waktuGaransi: json['waktu_garansi'],
      statusProdukHunting: json['status_produk_hunting'],
      rating:
          (json['rating'] != null && json['rating'] is num)
              ? (json['rating'] as num).toDouble()
              : null,
      kategori: Kategori.fromJson(json['kategori']),
      fotoProduk:
          (json['foto_produk'] as List)
              .map((e) => FotoProduk.fromJson(e))
              .toList(),

      // detail_penitipan
      idPenitipan: detailPenitipan['id_penitipan'],
      tanggalPengambilan: detailPenitipan['tanggal_pengambilan'],
      konfirmasiDonasi: detailPenitipan['konfirmasi_donasi'],

      // penitipan
      tanggalPenitipan: penitipan['tanggal_penitipan'],
      tenggatPenitipan: penitipan['tenggat_penitipan'],
      tenggatPengambilan: penitipan['tenggat_pengambilan'],
      statusPerpanjangan: penitipan['status_perpanjangan'],
      penitip: Penitip.fromJson(penitipan['penitip']),
      qc: Pegawai.fromJson(penitipan['qc']),
      hunter:
          penitipan['hunter'] != null
              ? Pegawai.fromJson(penitipan['hunter'])
              : null,
    );
  }
}
