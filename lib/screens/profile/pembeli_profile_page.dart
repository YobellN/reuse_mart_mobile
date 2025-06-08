import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/pembeli.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/riwayat_pembelian.dart';
import 'package:reuse_mart_mobile/services/pembeli_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PembeliProfileContent extends StatefulWidget {
  const PembeliProfileContent({super.key});

  @override
  State<PembeliProfileContent> createState() => _PembeliProfileContentState();
}

class _PembeliProfileContentState extends State<PembeliProfileContent> {
  Pembeli? _pembeli;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCachedDataThenFetchFresh();
  }

  Future<void> loadCachedDataThenFetchFresh() async {
    final cached = await PembeliService.getCachedPembeli();
    if (cached != null && mounted) {
      setState(() {
        _pembeli = cached;
        _isLoading = false;
      });
    }

    final fresh = await PembeliService.getPembeli();
    if (fresh != null && mounted) {
      setState(() {
        _pembeli = fresh;
      });
    }
  }

  Future<void> fetchProfile() async {
    if (_pembeli != null) return;

    setState(() {
      _isLoading = true;
    });

    final response = await PembeliService.getPembeli();

    if (!mounted) return;
    setState(() {
      _pembeli = response;
      _isLoading = false;
    });
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  final features = [
    {'icon': Icons.share, 'title': 'Affiliate commission', 'isNew': true},
    {'icon': Icons.pan_tool_alt, 'title': 'Referral', 'isNew': true},
    {'icon': Icons.card_giftcard, 'title': 'Scratch & Win', 'isNew': true},
  ];

  @override
  Widget build(BuildContext context) {
    final name = _pembeli?.user.nama ?? 'John Doe';
    final email = _pembeli?.user.email ?? 'example@email.com';
    final phone = _pembeli?.user.noTelp ?? '+628123456789';
    final poin = _pembeli?.pembeli.poin ?? 0;

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
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(phone, style: AppTextStyles.body),
                            const SizedBox(height: 2),
                            Text(email, style: AppTextStyles.caption),
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
                                    "Poin",
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
                                        Icons.workspace_premium,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        poin.toString(),
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
                      image: AssetImage('assets/icons/pembeli.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const PesananSayaSection(),
        const SizedBox(height: 16),
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
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      if (feature != features.last)
                        Divider(height: 1, color: Colors.grey.shade300),
                    ],
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white),
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

// PesananSayaSection dan _OrderIcon tetap seperti sebelumnya


class PesananSayaSection extends StatelessWidget {
  const PesananSayaSection({super.key});

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
                "Pesanan Saya",
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
                      builder: (context) => const RiwayatPembelianPage(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _OrderIcon(
                icon: Icons.payments_outlined,
                label: 'Belum Bayar',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatPembelianPage(
                            initialStatus: 'Belum Dibayar',
                          ),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.inventory_2_outlined,
                label: 'Disiapkan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              RiwayatPembelianPage(initialStatus: 'Disiapkan'),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.local_shipping_outlined,
                label: 'Dikirim',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatPembelianPage(initialStatus: 'Dikirim'),
                    ),
                  );
                },
              ),
              _OrderIcon(
                icon: Icons.inventory_2,
                label: 'Selesai',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => RiwayatPembelianPage(initialStatus: 'Selesai'),
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
