import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/detail_pembelian_page.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:intl/intl.dart';

class RiwayatPembelianCard extends StatelessWidget {
  final String namaPenitip;
  final String status;
  final List<ProdukRiwayat> produkList;
  final int totalJumlah;
  final int totalHarga;

  RiwayatPembelianCard({
    super.key,
    required this.namaPenitip,
    required this.status,
    required this.produkList,
    required this.totalJumlah,
    required this.totalHarga,
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
                (context) => DetailPesananPage(
                  produkList: produkList,
                  totalHarga: totalHarga,
                  namaPenitip: namaPenitip,
                  status: status,
                ),
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
                    namaPenitip,
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
                  produkList.map((produk) {
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
                              child: Image.asset(
                                produk.foto ??
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
                                        produk.nama,
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
                                        produk.kategori,
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
                                      currencyFormatter.format(produk.harga),
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
                      text: 'Total $totalJumlah produk: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: currencyFormatter.format(totalHarga),
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
