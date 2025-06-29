import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:reuse_mart_mobile/models/produk_titipan.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/card_riwayat_pembelian.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailProdukContent extends StatelessWidget {
  final ProdukTitipan produk;

  DetailProdukContent({super.key, required this.produk});

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
                    'Produk ${produk.statusAkhirProduk != null ? produk.statusAkhirProduk! : 'Tersedia'}',
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
                  value: produk.idPenitipan,
                ),
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Tanggal Penitipan',
                  value: DateFormat(
                    "dd MMMM yyyy",
                    "id_ID",
                  ).format(DateTime.parse(produk.tanggalPenitipan)),
                ),
                _InfoRow(
                  icon: Icons.hourglass_bottom,
                  label: 'Tenggat Penitipan',
                  value: DateFormat(
                    "dd MMMM yyyy",
                    "id_ID",
                  ).format(DateTime.parse(produk.tenggatPenitipan)),
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.update,
                  label: 'Status Perpanjang',
                  value:
                      produk.statusPerpanjangan == 1
                          ? 'Diperpanjang'
                          : 'Tidak Perpanjang',
                ),
                _InfoRow(
                  icon: Icons.event_available,
                  label: 'Tenggat Ambil',
                  value: DateFormat(
                    "dd MMMM yyyy",
                    "id_ID",
                  ).format(DateTime.parse(produk.tenggatPengambilan)),
                ),
                _InfoRow(
                  icon: Icons.volunteer_activism,
                  label: 'Konfirmasi Donasi',
                  value:
                      produk.konfirmasiDonasi == 1
                          ? 'Didonasikan'
                          : 'Tidak donasi',
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.person,
                  label: 'Nama Penitip',
                  value: produk.penitip.user.nama,
                ),
                _InfoRow(
                  icon: Icons.email,
                  label: 'Email',
                  value: produk.penitip.user.email,
                ),
                _InfoRow(
                  icon: Icons.phone,
                  label: 'Telepon',
                  value: produk.penitip.user.noTelp,
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
                  icon: Icons.inventory_2,
                  label: 'Status Ketersediaan',
                  value:
                      produk.statusKetersediaan ? 'Tersedia' : 'Tidak Tersedia',
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
                          '${Api.storageUrl}/${foto.pathFoto}',
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

          //INFO PIHAK TERKAIT
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
                  'Pihak Terkait',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Icon(Icons.person_search, color: Colors.green),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Hunter: '),
                          TextSpan(
                            text:
                                produk.hunter?.user.nama ??
                                'Bukan produk hunting',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Pegawai QC: '),
                          TextSpan(
                            text: produk.qc.user.nama,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 12),

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
