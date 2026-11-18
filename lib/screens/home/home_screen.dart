
import 'package:flutter/material.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';
import 'package:qr_scanner_pro/screens/home/widgets/feature_card.dart';
import 'package:qr_scanner_pro/screens/home/widgets/recent_scan_card.dart';
import 'package:qr_scanner_pro/screens/home/widgets/scan_action_card.dart';


class HomeScreen extends StatelessWidget {
  final VoidCallback onScanTap;
  final VoidCallback onGenerateTap;
  final VoidCallback onHistoryTap;

  const HomeScreen({
    super.key,
    required this.onScanTap,
    required this.onGenerateTap,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'QR Scanner Pro',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScanActionCard(onTap: onScanTap),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.qr_code_rounded,
                      iconColor: AppColors.secondary,
                      title: 'Generate QR',
                      subtitle: 'Create your own QR code',
                      onTap: onGenerateTap,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: FeatureCard(
                      icon: Icons.history_toggle_off,
                      iconColor: AppColors.accent,
                      title: 'Scan History',
                      subtitle: 'View Previous Scan',
                      onTap: onHistoryTap,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const RecentScansCard(),
            ],
          ),
        ),
      ),
    );
  }
}
