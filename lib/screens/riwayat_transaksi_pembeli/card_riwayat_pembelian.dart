import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/detail_pembelian_page.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:intl/intl.dart';

class RiwayatPembelianCard extends StatelessWidget {
  final Penjualan penjualan;

  RiwayatPembelianCard({
    super.key,
    required this.penjualan
  });

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailPembelianPage(penjualan: penjualan),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat(
                      "dd MMMM yyyy",
                      "id_ID",
                    ).format(DateTime.parse(penjualan.tanggalPenjualan)),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    penjualan.statusPenjualan,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),

            Column(
              children:
                  penjualan.detailProduk.map((produk) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.border,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child:
                                  produk.fotoProduk.isNotEmpty
                                      ? Image.network(
                                        '${Api.storageUrl}/${produk.fotoProduk.first.pathFoto}',
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Image.asset(
                                            'assets/icons/reuse-mart-icon.png',
                                            width: 85,
                                            height: 85,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        errorBuilder:
                                            (
                                              context,
                                              error,
                                              stackTrace,
                                            ) => Image.asset(
                                              'assets/icons/reuse-mart-icon.png',
                                              width: 85,
                                              height: 85,
                                              fit: BoxFit.cover,
                                            ),
                                      )
                                      : Image.asset(
                                        'assets/icons/reuse-mart-icon.png',
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      ),
                            ),

                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 85,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        produk.namaProduk,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        produk.kategori.namaKategori,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      currencyFormatter.format(
                                        produk.hargaProduk,
                                      ),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total ${penjualan.detailProduk.length} produk: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: currencyFormatter.format(penjualan.totalHarga),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkPastelGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProdukRiwayat {
  final String nama;
  final String kategori;
  final int harga;
  final String? foto;

  ProdukRiwayat({
    required this.nama,
    required this.kategori,
    required this.harga,
    this.foto,
  });
}
