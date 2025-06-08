import 'detail_produk_titipan.dart';

class Penjualan {
  final String idPenjualan;
  final String tanggalPenjualan;
  final String metodePengiriman;
  final String? jadwalPengambilan;
  final int? totalOngkir;
  final int poinPerolehan;
  final int poinPotongan;
  final int totalHarga;
  final int totalPoin;
  final String statusPenjualan;
  final String? tenggatPembayaran;

  final String? namaPembeli;
  final String? emailPembeli;
  final String? noTelpPembeli;

  final List<DetailProdukTitipan> detailProduk;

  final String? tanggalPembayaran;
  final String? metodePembayaran;
  final String? statusPembayaran;
  final String? buktiPembayaran;

  final String? jadwalPengiriman;
  final String? statusPengiriman;
  final String? namaKurir;
  final String? labelAlamat;
  final String? detailAlamat;

  Penjualan({
    required this.idPenjualan,
    required this.tanggalPenjualan,
    required this.metodePengiriman,
    this.jadwalPengambilan,
    required this.totalOngkir,
    required this.poinPerolehan,
    required this.poinPotongan,
    required this.totalHarga,
    required this.totalPoin,
    required this.statusPenjualan,
    this.tenggatPembayaran,
    this.namaPembeli,
    this.emailPembeli,
    this.noTelpPembeli,
    required this.detailProduk,
    this.tanggalPembayaran,
    this.metodePembayaran,
    this.statusPembayaran,
    this.buktiPembayaran,
    this.jadwalPengiriman,
    this.statusPengiriman,
    this.namaKurir,
    this.labelAlamat,
    this.detailAlamat,
  });

  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      idPenjualan: json['id_penjualan'],
      tanggalPenjualan: json['tanggal_penjualan'],
      metodePengiriman: json['metode_pengiriman'],
      jadwalPengambilan: json['jadwal_pengambilan'],
      totalOngkir: json['total_ongkir'] ?? 0,
      poinPerolehan: json['poin_perolehan'] ?? 0,
      poinPotongan: json['poin_potongan'] ?? 0,
      totalHarga: json['total_harga'],
      totalPoin: json['total_poin'],
      statusPenjualan: json['status_penjualan'],
      tenggatPembayaran: json['tenggat_pembayaran'],
      namaPembeli: json['pembeli']?['user']?['nama'],
      emailPembeli: json['pembeli']?['user']?['email'],
      noTelpPembeli: json['pembeli']?['user']?['no_telp'],
      detailProduk:
          (json['detail'] as List)
              .map((item) => DetailProdukTitipan.fromJson(item['produk']))
              .toList(),
      tanggalPembayaran: json['pembayaran']?['tanggal_pembayaran'],
      metodePembayaran: json['pembayaran']?['metode_pembayaran'],
      statusPembayaran: json['pembayaran']?['status_pembayaran'],
      buktiPembayaran: json['pembayaran']?['bukti_pembayaran'],
      jadwalPengiriman: json['pengiriman']?['jadwal_pengiriman'],
      statusPengiriman: json['pengiriman']?['status_pengiriman'],
      namaKurir: json['pengiriman']?['kurir']?['user']?['nama'],
      labelAlamat: json['pengiriman']?['alamat']?['label'],
      detailAlamat: json['pengiriman']?['alamat']?['detail_alamat'],
    );
  }
}
