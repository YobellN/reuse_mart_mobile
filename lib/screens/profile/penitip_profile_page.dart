import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/models/penitip_detail.dart';
import 'package:reuse_mart_mobile/screens/riwayat_produk_penitip/riwayat_produk_page.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reuse_mart_mobile/services/penitip_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PenitipProfileContent extends StatefulWidget {
  const PenitipProfileContent({super.key});

  @override
  State<PenitipProfileContent> createState() => _PenitipProfileContentState();
}

class _PenitipProfileContentState extends State<PenitipProfileContent> {
  PenitipDetail? _penitip;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPenitipProfile();
  }

  final features = [
    {'icon': Icons.share, 'title': 'Affiliate commission', 'isNew': true},
    {'icon': Icons.pan_tool_alt, 'title': 'Referral', 'isNew': true},
    {'icon': Icons.card_giftcard, 'title': 'Scratch & Win', 'isNew': true},
  ];

  Future<void> _loadPenitipProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedPenitip = prefs.getString('cached_penitip');
    if (cachedPenitip != null) {
      setState(() {
        _penitip = PenitipDetail.fromJson(json.decode(cachedPenitip));
        _isLoading = false;
      });
    }
    final fetched = await PenitipService.fetchPenitip();
    if (!mounted) return;
    setState(() {
      _penitip = fetched;
      _isLoading = false;
    });
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('id_penitip');
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
                              _penitip?.user.nama ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _penitip?.user.noTelp ?? '',
                              style: AppTextStyles.body,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _penitip?.user.email ?? '',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightMintGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Poin",
                                          style: AppTextStyles.bodyBold,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.workspace_premium,
                                              color: AppColors.softPastelGreen,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _penitip?.poin.toString() ?? '0',
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightMintGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Saldo",
                                          style: AppTextStyles.bodyBold,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.account_balance_wallet,
                                              color: AppColors.softPastelGreen,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              NumberFormat.currency(
                                                locale: 'id_ID',
                                                symbol: 'Rp ',
                                                decimalDigits: 0,
                                              ).format(_penitip?.saldo ?? 0),
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightMintGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rating",
                                          style: AppTextStyles.bodyBold,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.softPastelGreen,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _penitip?.rating.toString() ??
                                                  'Belum ada',
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightMintGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Produk",
                                          style: AppTextStyles.bodyBold,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.inventory_2_outlined,
                                              color: AppColors.softPastelGreen,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _penitip?.totalProduk
                                                      .toString() ??
                                                  'Belum ada',
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                      image: AssetImage('assets/icons/penitip.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // SECTION MENU PROFIL
        if (_penitip != null) ProdukSayaSection(idPenitip: _penitip!.idPenitip),
        const SizedBox(height: 16),

        // SECTION INFO UMUM
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: const BoxDecoration(color: Colors.white),
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

        // TOMBOL LOGOUT
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => logout(context),
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

class ProdukSayaSection extends StatelessWidget {
  final String idPenitip;
  const ProdukSayaSection({super.key, required this.idPenitip});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Produk Saya",
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
                      builder:
                          (_) => RiwayatProdukPage(
                            idPenitip: idPenitip,
                            initialStatus: 'Semua',
                          ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Lihat semua riwayat",
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

          // Shortcut icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _OrderIcon(
                icon: Icons.check_circle,
                label: 'Tersedia',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatProdukPage(
                            idPenitip: idPenitip,
                            initialStatus: 'Tersedia',
                          ),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.highlight_off,
                label: 'Tidak Laku',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatProdukPage(
                            idPenitip: idPenitip,
                            initialStatus: 'Tidak Laku',
                          ),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.volunteer_activism,
                label: 'Didonasikan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatProdukPage(
                            idPenitip: idPenitip,
                            initialStatus: 'Didonasikan',
                          ),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.inventory,
                label: 'Terjual',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatProdukPage(
                            idPenitip: idPenitip,
                            initialStatus: 'Terjual',
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
    return GestureDetector(
      onTap: onTap,
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

