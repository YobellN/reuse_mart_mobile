import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk_titipan.dart';
import 'package:reuse_mart_mobile/screens/riwayat_produk_penitip/detail_product_content.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailProdukPage extends StatelessWidget {
  final ProdukTitipan produk;
  const DetailProdukPage({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Detail Produk', style: AppTextStyles.appBarText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DetailProdukContent(produk: produk),
    );
  }
}
