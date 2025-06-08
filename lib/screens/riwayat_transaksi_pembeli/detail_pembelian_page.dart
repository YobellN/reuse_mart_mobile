import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/detail_pembelian_content.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailPembelianPage extends StatelessWidget {
  final Penjualan penjualan;

  const DetailPembelianPage({
    super.key,
    required this.penjualan,
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
      body: DetailPesananContent(penjualan: penjualan),
    );
  }
}
