
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';
import 'package:qr_scanner_pro/screens/scanner/widgets/scanner_frame.dart';

import '../../state/history_state.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _hasScanned = false;

  Future<void> _handleDetection(BarcodeCapture capture) async {
    if (_hasScanned) return;

   if (capture.barcodes.isEmpty) return;

      final String? scannedValue =
        capture.barcodes.first.rawValue;

    if (scannedValue == null || scannedValue.trim().isEmpty) {
      return;
    }

    _hasScanned = true;

    await context.read<HistoryState>().addHistory(
          content: scannedValue,
          type: 'scanned',
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          scannedValue,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'QR Scanner',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                'Scan QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Position the QR code inside the frame',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              ScannerFrame(
                onDetect: _handleDetection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
