import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class LoginTabButton extends StatelessWidget {
  const LoginTabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text('Anda belum login', style: AppTextStyles.heading2),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              textStyle: AppTextStyles.bodyBold,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/login');
              if (result == true) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login berhasil!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}