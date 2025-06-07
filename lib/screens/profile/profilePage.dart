import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/profile/hunterProfilePage.dart';
import 'package:reuse_mart_mobile/screens/profile/kurirProfilePage.dart';
import 'package:reuse_mart_mobile/screens/profile/pembeli_profile_page.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class ProfilePage extends StatelessWidget {
  final String role;
  final String name;
  final String email;
  final String? photoUrl;
  final int? komisi;
  final int? poin;
  final String? nomorTelpon;
  final List<Map<String, dynamic>>? komisiHistory;

  const ProfilePage({
    super.key,
    required this.role,
    required this.name,
    required this.email,
    this.photoUrl,
    this.komisi,
    this.komisiHistory,
    this.poin,
    this.nomorTelpon,
  });

  @override
  Widget build(BuildContext context) {

    Widget content;
    switch (role) {
      case 'Hunter':
        content = HunterProfilePage(
          name: name,
          email: email,
          photoUrl: photoUrl,
          phone: nomorTelpon ?? '',
          poin: poin ?? 0,
        );
        break;
      case 'Kurir':
        content = KurirProfilePage(
          name: name,
          email: email,
          photoUrl: photoUrl,
        );
        break;
      case 'Pembeli':
        content = PembeliProfileContent(
          name: name,
          email: email,
          photoUrl: photoUrl,
          phone: nomorTelpon ?? '',
          poin: poin ?? 0,
        );
        break;
      default:
        content = const SizedBox.shrink();
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil', style: AppTextStyles.appBarText),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: content),
    );
  }
}
