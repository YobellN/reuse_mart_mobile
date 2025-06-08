import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/card_riwayat_pembelian.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailKomisiContent extends StatelessWidget {
  final String statusPesanan;
  final String tanggalPesanan;
  final String nomorPesanan;
  final String namaPembeli;
  final String email;
  final String noTelepon;
  final String metodePengiriman;
  final String alamatPengiriman;

  const DetailKomisiContent({
    super.key,
    required this.statusPesanan,
    required this.tanggalPesanan,
    required this.nomorPesanan,
    required this.namaPembeli,
    required this.email,
    required this.noTelepon,
    required this.metodePengiriman,
    required this.alamatPengiriman,
  });

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
                    color: AppColors.softPastelGreen,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Pesanan $statusPesanan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Tanggal Pesanan',
                  value: tanggalPesanan,
                ),
                _InfoRow(
                  icon: Icons.confirmation_number,
                  label: 'Nomor Pesanan',
                  value: nomorPesanan,
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.person,
                  label: 'Nama Pembeli',
                  value: namaPembeli,
                ),
                _InfoRow(icon: Icons.email, label: 'Email', value: email),
                _InfoRow(icon: Icons.phone, label: 'Telepon', value: noTelepon),
                _divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Info Pengiriman',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_shipping,
                            size: 20,
                            color: AppColors.softPastelGreen,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            metodePengiriman,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alamat Pembeli',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: AppColors.softPastelGreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              alamatPengiriman,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // LIST PRODUK PESANAN
          // RiwayatPembelianCard(
          //   namaPenitip: 'boscollection',
          //   status: 'Selesai',
          //   produkList: [
          //     ProdukRiwayat(
          //       nama: 'Celana Jogger Panjang Jogger Swe...',
          //       kategori: 'Pakaian & Aksesori',
          //       harga: 74869,
          //       foto: 'assets/icons/reuse-mart-icon.png',
          //     ),
          //   ],
          //   totalJumlah: 1,
          //   totalHarga: 86025,
          // ),

          //INFO POIN
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
                  'Poin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.green),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Poin diperoleh: '),
                          TextSpan(
                            text: '404',
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
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Poin digunakan: '),
                          TextSpan(
                            text: '100',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' (Diskon Rp1000000)'),
                        ],
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.orange),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Total poin setelah transaksi : '),
                          TextSpan(
                            text: '504',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          //INFO PEMBAYARAN
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
                  'Rincian Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                _rowItem('Tanggal Pembayaran', '03 Jun 2025, 14:29'),
                _rowItem('Metode Pembayaran', 'BCA'),
                _rowItem('Subtotal', 'Rp3.370.000'),
                _rowItem('Diskon', '- Rp1.000.000', valueColor: Colors.red),
                _rowItem('Ongkos Kirim', 'Rp0'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          //INFO TOTAL
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    ' Total Pembayaran',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  'Rp1000000',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      height: 0.5,
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
