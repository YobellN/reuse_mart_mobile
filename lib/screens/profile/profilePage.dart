import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/profile/hunter_profile_page.dart';
import 'package:reuse_mart_mobile/screens/profile/kurirProfilePage.dart';
import 'package:reuse_mart_mobile/screens/profile/pembeli_profile_page.dart';
import 'package:reuse_mart_mobile/screens/profile/penitip_profile_page.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class ProfilePage extends StatelessWidget {
  final String role;

  const ProfilePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (role) {
      case 'Hunter':
        content = const HunterProfilePage();
        break;
      case 'Kurir':
        content = KurirProfilePage(); 
        break;
      case 'Pembeli':
        content = PembeliProfileContent(); 
        break;
      case 'Penitip':
        content = PenitipProfileContent(); 
        break;
      default:
        content = const Center(child: Text('Role tidak dikenali'));
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
