
import 'package:flutter/material.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';

class RecentScansCard extends StatelessWidget {
  const RecentScansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Scans',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Your recent QR scans will appear here.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              'No scans yet',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
