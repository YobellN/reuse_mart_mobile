import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/services/auth_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class KurirProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;

  const KurirProfilePage({super.key, required this.name, required this.email, this.photoUrl});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
                backgroundColor: AppColors.disabled,
                child: photoUrl == null ? Icon(Icons.person, size: 40, color: AppColors.textInverse) : null,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.heading2),
                    const SizedBox(height: 4),
                    Text(email, style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Kurir', style: AppTextStyles.caption.copyWith(color: AppColors.textInverse)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Icon(Icons.delivery_dining, color: AppColors.primary),
            title: Text('Akun kurir untuk mengantar pesanan', style: AppTextStyles.bodyBold),
            subtitle: Text('Antarkan pesanan pelanggan dengan cepat dan aman.', style: AppTextStyles.caption),
          ),
        ),
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