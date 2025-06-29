import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/models/produk_hunter.dart';
import 'package:reuse_mart_mobile/screens/catalogue/skeleton_image.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/detail_komisi_page.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class RiwayatKomisiCard extends StatelessWidget {
  final ProdukHunter produk;

  RiwayatKomisiCard({super.key, required this.produk});

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final pathFoto = produk.fotoProduk.any((element) => element.thumbnail == 1)
        ? produk.fotoProduk
            .firstWhere((element) => element.thumbnail == 1)
            .pathFoto
        : 'assets/images/reuse-mart.png';
    final fotoProduk = '${Api.storageUrl}/$pathFoto';
    final String status;

    if (produk.statusAkhirProduk == 'Diambil' ||
        produk.statusAkhirProduk == 'Akan Diambil') {
      status = 'Batal';
    } else if ((produk.statusAkhirProduk == 'Terjual' ||
            produk.statusAkhirProduk == 'Produk untuk donasi' ||
            produk.statusAkhirProduk == 'Didonasikan') &&
        produk.detailPenjualan?.komisi != null) {
      status = 'Selesai';
    } else {
      status = 'Menunggu';
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKomisiPage(produk: produk),
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
                    formatTanggal(
                      produk.detailPenitipan.penitipan.tanggalPenitipan,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          status == 'Batal'
                              ? AppColors.error
                              : status == 'Menunggu'
                              ? AppColors.info
                              : AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),

            Column(
              children: [
                Padding(
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
                          child: SkeletonImage(
                            imageUrl:
                                fotoProduk,
                            width: 85,
                            height: 85,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                          ),
                          // Image.network(
                          //   fotoProduk,
                          //   height: 85,
                          //   width: 85,
                          //   fit: BoxFit.cover,
                          //   loadingBuilder: (context, child, loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Image(
                          //       image: const AssetImage(
                          //         'assets/icons/reuse-mart-icon.png',
                          //       ),
                          //       height: 85,
                          //       width: 85,
                          //       fit: BoxFit.cover,
                          //     );
                          //   },
                          //   errorBuilder:
                          //       (context, error, stackTrace) => Image(
                          //         image: const AssetImage(
                          //           'assets/icons/reuse-mart-icon.png',
                          //         ),
                          //         height: 85,
                          //         width: 85,
                          //         fit: BoxFit.cover,
                          //       ),
                          // ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  currencyFormatter.format(produk.hargaProduk),
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
                ),
              ],
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
                      text: 'Komisi: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                          produk.detailPenjualan?.komisi?.komisiHunter != null
                              ? currencyFormatter.format(
                                produk.detailPenjualan?.komisi?.komisiHunter,
                              )
                              : 'Belum ada komisi',
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
  final ProdukHunter produk;

  ProdukRiwayat({required this.produk});
}
