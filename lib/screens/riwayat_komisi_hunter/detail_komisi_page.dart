import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/card_riwayat_komisi.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/detail_pembelian_content.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailKomisiPage extends StatelessWidget {
  final List<ProdukRiwayat> produkList;
  final int totalHarga;
  final String namaPenitip;
  final String status;

  const DetailKomisiPage({
    super.key,
    required this.produkList,
    required this.totalHarga,
    required this.namaPenitip,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Detail Pesanan', style: AppTextStyles.appBarText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DetailKomisiContent(
        statusPesanan: status,
        tanggalPesanan: '07-06-2025',
        nomorPesanan: 'INV20250607001',
        namaPembeli: 'Budi Santoso',
        email: 'budi@example.com',
        noTelepon: '081234567890',
        metodePengiriman: 'Kurir Internal',
        alamatPengiriman: 'Jl. Melati No.123, Sleman, Yogyakarta 55281',

        // produkList: produkList,
        // totalHarga: totalHarga,
        // namaPenitip: namaPenitip,
      ),
    );
  }
}
