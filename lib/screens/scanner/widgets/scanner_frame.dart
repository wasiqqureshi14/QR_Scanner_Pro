
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';

class ScannerFrame extends StatelessWidget {
  final void Function(BarcodeCapture capture) onDetect;

  const ScannerFrame({
    super.key,
    required this.onDetect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: MobileScanner(
        onDetect: onDetect,
      ),
    );
  }
}
