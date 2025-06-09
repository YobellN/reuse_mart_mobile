import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/pegawai.dart';
import 'package:reuse_mart_mobile/screens/riwayat_pengantaran_kurir/riwayat_pengiriman_page.dart';
import 'package:reuse_mart_mobile/services/auth_service.dart';
import 'package:reuse_mart_mobile/services/kurir_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class KurirProfilePage extends StatefulWidget {
  // final String name;
  // final String email;
  // final String? photoUrl;

  const KurirProfilePage({
    super.key,
    // required this.name,
    // required this.email,
    // this.photoUrl,
  });

  @override
  State<KurirProfilePage> createState() => _KurirProfilePageState();
}

class _KurirProfilePageState extends State<KurirProfilePage> {
  Pegawai? _pegawai;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getKurir();
  }

  Future<void> getKurir() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_kurir');
    if (cached != null) {
      if (!mounted) return;
      setState(() {
        _pegawai = Pegawai.fromJson(jsonDecode(cached));
        _isLoading = false;
      });
    }
    final fresh = await KurirService.getKurir();
    if (fresh != null) {
      if (!mounted) return;
      setState(() {
        _pegawai = fresh;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(height: 120, color: AppColors.primary),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
              child: Skeletonizer(
                enabled: _isLoading,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromARGB(255, 213, 213, 213),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                          bottom: 24,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          children: [
                            Text(
                              _pegawai?.user.nama ?? 'Memuat...',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _pegawai?.user.noTelp ?? '',
                              style: AppTextStyles.body,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _pegawai?.user.email ?? 'Memuat...',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tanggal Lahir: ${formatTanggal(_pegawai?.tanggalLahir)}',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 16),
                            // Tombol History Pengiriman
                            Container(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              const RiwayatPengirimanKurirPage(
                                                initialStatus: 'Semua',
                                              ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.local_shipping,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Riwayat Pengiriman",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
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
            ),
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/icons/hunter.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Section Info Pengiriman
        DeliveryStatusSection(),
        const SizedBox(height: 16),

        //TOMBOL LOGOUT
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => AuthService.logout(context),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DeliveryStatusSection extends StatelessWidget {
  const DeliveryStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status Pengiriman",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatusIcon(
                icon: Icons.pending_outlined,
                label: 'Menunggu Kurir',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => const RiwayatPengirimanKurirPage(
                            initialStatus: 'Menunggu Kurir',
                          ),
                    ),
                  );
                },
              ),
              _StatusIcon(
                icon: Icons.local_shipping_outlined,
                label: 'Diambil oleh kurir',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => const RiwayatPengirimanKurirPage(
                            initialStatus: 'Diambil oleh kurir',
                          ),
                    ),
                  );
                },
              ),
              _StatusIcon(
                icon: Icons.check_circle_outline,
                label: 'Selesai',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => const RiwayatPengirimanKurirPage(
                            initialStatus: 'Selesai',
                          ),
                    ),
                  );
                },
              ),
              _StatusIcon(
                icon: Icons.cancel_outlined,
                label: 'Dibatalkan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => const RiwayatPengirimanKurirPage(
                            initialStatus: 'Dibatalkan',
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StatusIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Icon(icon, color: AppColors.softPastelGreen, size: 30),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
