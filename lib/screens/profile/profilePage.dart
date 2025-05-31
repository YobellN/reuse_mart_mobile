import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/profile/hunterProfilePage.dart';
import 'package:reuse_mart_mobile/screens/profile/kurirProfilePage.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';


class ProfilePage extends StatelessWidget {
  final String role;
  final String name;
  final String email;
  final String? photoUrl;
  final int? komisi;
  final List<Map<String, dynamic>>? komisiHistory;

  const ProfilePage({
    super.key,
    required this.role,
    required this.name,
    required this.email,
    this.photoUrl,
    this.komisi,
    this.komisiHistory,
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
          komisi: komisi ?? 0,
          komisiHistory: komisiHistory ?? [],
        );
        break;
      case 'Kurir':
        content = KurirProfilePage(name: name, email: email, photoUrl: photoUrl);
        break;
      default:
        content = const SizedBox.shrink();
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil', style: AppTextStyles.heading3),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: content,
      ),
    );
  }
}
