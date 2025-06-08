import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/kurir.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:intl/intl.dart';

class RiwayatPengirimanCard extends StatelessWidget {
  final PengirimanKurir pengiriman;
  final Function()? onSelesaiPressed;

  const RiwayatPengirimanCard({
    super.key,
    required this.pengiriman,
    this.onSelesaiPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID: ${pengiriman.idPenjualan}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                pengiriman.statusPengiriman,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          
          // Informasi Pembeli
          Text(
            pengiriman.alamat.pembeli.user.nama,
            style: AppTextStyles.bodyBold,
          ),
          const SizedBox(height: 4),
          Text(
            pengiriman.alamat.pembeli.user.noTelp,
            style: AppTextStyles.caption,
          ),
          
          const SizedBox(height: 12),
          
          // Informasi Alamat
          Text(
            'Alamat Pengiriman:',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${pengiriman.alamat.detailAlamat}\n${pengiriman.alamat.kecamatan}, ${pengiriman.alamat.kabupatenKota} ${pengiriman.alamat.kodePos}',
            style: AppTextStyles.body,
          ),
          
          const SizedBox(height: 12),
          
          // Jadwal Pengiriman
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Jadwal: ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(pengiriman.jadwalPengiriman))}',
                style: AppTextStyles.caption,
              ),
            ],
          ),

          // Tombol Selesai
          if (pengiriman.statusPengiriman == "Diambil oleh kurir")
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSelesaiPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Selesaikan Pengiriman'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
