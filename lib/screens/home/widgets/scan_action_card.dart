
import 'package:flutter/material.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';

class ScanActionCard extends StatelessWidget {
  final VoidCallback onTap;

  const ScanActionCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.qr_code_scanner,
            color: AppColors.accent,
            size: 45,
          ),

          const SizedBox(height: 12),

          const Text(
            'Scan Any QR Code',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Scan QR codes instantly with your camera',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              child: const Text('SCAN QR CODE'),
            ),
          ),
        ],
      ),
    );
  }
}
