import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk_hunter.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/detail_komisi_content.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailKomisiPage extends StatelessWidget {
  final ProdukHunter produk;

  const DetailKomisiPage({
    super.key,
    required this.produk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Detail Komisi', style: AppTextStyles.appBarText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DetailKomisiContent(produk: produk),
    );
  }
}
