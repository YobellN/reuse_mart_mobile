import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/card_riwayat_pembelian.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailPesananContent extends StatelessWidget {
final Penjualan penjualan;

  DetailPesananContent({super.key, required this.penjualan});

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
                    color: AppColors.softPastelGreen,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Pesanan ${penjualan.statusPenjualan}',
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
                  value: DateFormat(
                    "dd MMMM yyyy",
                    "id_ID",
                  ).format(DateTime.parse(penjualan.tanggalPenjualan)),
                ),
                _InfoRow(
                  icon: Icons.confirmation_number,
                  label: 'Nomor Pesanan',
                  value: penjualan.idPenjualan,
                ),
                _divider(),
                _InfoRow(
                  icon: Icons.person,
                  label: 'Nama Pembeli',
                  value: penjualan.namaPembeli ?? '-',
                ),
                _InfoRow(
                  icon: Icons.email,
                  label: 'Email',
                  value: penjualan.emailPembeli ?? '-',
                ),
                _InfoRow(
                  icon: Icons.phone,
                  label: 'Telepon',
                  value: penjualan.noTelpPembeli ?? '-',
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
                            penjualan.metodePengiriman == 'Antar Kurir'
                                ? 'Kurir: ${penjualan.namaKurir}'
                                : 'Pengambilan Sendiri',
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
                      Text(
                        penjualan.labelAlamat != null
                            ? 'Alamat Pembeli'
                            : 'Info Pengambilan ke Gudang',
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
                              penjualan.labelAlamat ?? 'Ambil di Gudang pada ',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              penjualan.detailAlamat ??
                                  (penjualan.jadwalPengambilan != null
                                      ? DateFormat(
                                        "dd MMMM yyyy, HH:mm",
                                        "id_ID",
                                      ).format(
                                        DateTime.parse(
                                          penjualan.jadwalPengambilan!,
                                        ),
                                      )
                                      : '-'),
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
          RiwayatPembelianCard(
            penjualan: penjualan,
          ),

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
                  'Informasi Poin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.card_giftcard, color: Colors.green),
                    const SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Poin diperoleh: '),
                          TextSpan(
                            text: '${penjualan.poinPerolehan}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.card_giftcard, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Poin digunakan: '),
                          TextSpan(
                            text: '${penjualan.poinPotongan}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ' (Diskon ${currencyFormatter.format(penjualan.poinPotongan * 100)})',
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.card_giftcard, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Total poin setelah transaksi : ',
                          ),
                          TextSpan(
                            text: '${penjualan.totalPoin}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 13),
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

                _rowItem(
                  'Tanggal Pembayaran',
                  penjualan.tanggalPembayaran ?? '-',
                ),
                _rowItem(
                  'Metode Pembayaran',
                  penjualan.metodePembayaran ?? '-',
                ),
                _rowItem(
                  'Subtotal',
                  currencyFormatter.format(
                    penjualan.detailProduk.fold<int>(
                      0,
                      (sum, item) => sum + item.hargaProduk,
                    ),
                  ),
                ),
                _rowItem(
                  'Diskon',
                  currencyFormatter.format(penjualan.poinPotongan * 100),
                  valueColor: Colors.red,
                ),
                _rowItem(
                  'Ongkos Kirim',
                  currencyFormatter.format(penjualan.totalOngkir),
                ),
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
                  currencyFormatter.format(penjualan.totalHarga),
                  // penjualan.totalHarga.toString(),
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
