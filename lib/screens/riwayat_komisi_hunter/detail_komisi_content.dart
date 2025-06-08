import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/models/produk_hunter.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailKomisiContent extends StatelessWidget {
  final ProdukHunter produk;

  DetailKomisiContent({super.key, required this.produk});

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        children: [
          // CARD UTAMA
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.darkPastelGreen,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Komisi',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.confirmation_number,
                  label: 'Nomor Nota Penitipan',
                  value: produk.detailPenitipan.penitipan.idPenitipan,
                ),
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Tanggal Penitipan',
                  value: DateFormat("dd MMMM yyyy", "id_ID").format(
                    DateTime.parse(
                      produk.detailPenitipan.penitipan.tanggalPenitipan,
                    ),
                  ),
                ),
                _InfoRow(
                  icon: Icons.update,
                  label: 'Status Perpanjang',
                  value:
                      produk.detailPenitipan.penitipan.statusPerpanjangan == 1
                          ? 'Diperpanjang'
                          : 'Tidak Perpanjang',
                ),
                _InfoRow(
                  icon: Icons.person,
                  label: 'Nama Penitip',
                  value: produk.detailPenitipan.penitipan.penitip.user.nama,
                ),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: 'Komisi',
                  value: produk.detailPenjualan?.komisi?.komisiHunter != null ? formatHarga(produk.detailPenjualan?.komisi?.komisiHunter) : 'Belum ada komisi',
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.softPastelGreen,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Detail Produk',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.shopping_bag,
                  label: 'Nama Produk',
                  value: produk.namaProduk,
                ),
                _InfoRow(
                  icon: Icons.category,
                  label: 'Kategori',
                  value: produk.kategori.namaKategori,
                ),
                _InfoRow(
                  icon: Icons.price_check,
                  label: 'Harga',
                  value: currencyFormatter.format(produk.hargaProduk),
                ),
                _InfoRow(
                  icon: Icons.description,
                  label: 'Deskripsi Produk',
                  value: produk.deskripsiProduk,
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // SECTION FOTO PRODUK
          if (produk.fotoProduk.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Foto Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: produk.fotoProduk.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final foto = produk.fotoProduk[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '${Api.storageUrl}foto_produk/${foto.pathFoto}',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Image.asset(
                                'assets/icons/reuse-mart-icon.png',
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      height: 0.7,
      color: Colors.grey.shade300,
    );
  }

  Widget _rowItem(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.softPastelGreen),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
