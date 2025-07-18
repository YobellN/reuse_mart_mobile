import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/pegawai.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/riwayat_komisi.dart';
import 'package:reuse_mart_mobile/services/auth_service.dart';
import 'package:reuse_mart_mobile/services/hunter_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HunterProfilePage extends StatefulWidget {


  const HunterProfilePage({
    super.key,
  });

  @override
  State<HunterProfilePage> createState() => _HunterProfilePageState();
}

class _HunterProfilePageState extends State<HunterProfilePage> {
  final features = [
    {'icon': Icons.share, 'title': 'Affiliate commission', 'isNew': true},
    {'icon': Icons.pan_tool_alt, 'title': 'Referral', 'isNew': true},
    {'icon': Icons.card_giftcard, 'title': 'Scratch & Win', 'isNew': true},
  ];

  Pegawai? _pegawai;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getHunter();
  }

  Future<void> getHunter() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_hunter');
    if (cached != null) {
      if (!mounted) return;
      setState(() {
        _pegawai = Pegawai.fromJson(jsonDecode(cached));
        _isLoading = false;
      });
    }
    final fresh = await HunterService.getHunter();
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
                              _pegawai?.user.nama ?? 'John Doe',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _pegawai?.user.noTelp ?? '+628123456789',
                              style: AppTextStyles.body,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _pegawai?.user.email ?? 'N4oLb@example.com',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tanggal Lahir:${formatTanggal(_pegawai?.tanggalLahir)}',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightMintGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Komisi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        formatHarga(_pegawai?.totalKomisi ?? 0),
                                        style: AppTextStyles.body.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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

        //  SECTION MENU PROFIL
        RiwayatKomisiSection(),
        const SizedBox(height: 16),

        //  SECTION INFO UMUM
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children:
                features.map((feature) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          feature['icon'] as IconData,
                          color: Colors.grey.shade700,
                        ),
                        title: Row(
                          children: [
                            Text(
                              feature['title'] as String,
                              style: AppTextStyles.body,
                            ),
                            const SizedBox(width: 8),
                            // if (feature['isNew'] == true)
                            //   Container(
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 8,
                            //       vertical: 2,
                            //     ),
                            //     decoration: BoxDecoration(
                            //       color: Colors.red,
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     child: const Text(
                            //       'New',
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // TODO: Add navigation
                        },
                      ),
                      if (feature != features.last)
                        Divider(height: 1, color: Colors.grey.shade300),
                    ],
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        //TOMBOL LOGOUT
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white),
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

class RiwayatKomisiSection extends StatelessWidget {
  const RiwayatKomisiSection({super.key});

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
                "Riwayat Hunting",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiwayatKomisiPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Lihat semua",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softPastelGreen,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: AppColors.softPastelGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _OrderIcon(
                icon: Icons.payments_outlined,
                label: 'Selesai',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatKomisiPage(
                            initialStatus: 'Selesai',
                          ),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.refresh_outlined,
                label: 'Menunggu',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              RiwayatKomisiPage(initialStatus: 'Menunggu'),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.cancel_outlined,
                label: 'Batal',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatKomisiPage(initialStatus: 'Batal'),
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

class _OrderIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OrderIcon({
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