import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class HunterProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;
  final int komisi;
  final List<Map<String, dynamic>> komisiHistory;

  const HunterProfilePage({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.komisi,
    required this.komisiHistory,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    photoUrl != null ? NetworkImage(photoUrl!) : null,
                backgroundColor: AppColors.disabled,
                child:
                    photoUrl == null
                        ? Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.textInverse,
                        )
                        : null,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Hunter',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textInverse,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Komisi summary
        Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          color: AppColors.success.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: AppColors.success, size: 36),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Komisi', style: AppTextStyles.caption),
                    Text(
                      'Rp ${komisi.toString()}',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Komisi history
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Riwayat Komisi', style: AppTextStyles.heading3),
        ),
        const SizedBox(height: 8),
        komisiHistory.isEmpty
            ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Belum ada riwayat komisi.',
                style: AppTextStyles.caption,
              ),
            )
            : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: komisiHistory.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = komisiHistory[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.receipt_long, color: AppColors.primary),
                    ),
                    title: Text(
                      item['deskripsi'] ?? '-',
                      style: AppTextStyles.bodyBold,
                    ),
                    subtitle: Text(
                      'Tanggal: ${item['tanggal'] ?? '-'}',
                      style: AppTextStyles.caption,
                    ),
                    trailing: Text(
                      'Rp ${item['jumlah'] ?? 0}',
                      style: AppTextStyles.bodyBold.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }
}
