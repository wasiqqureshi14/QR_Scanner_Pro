import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'app_routes.dart';

class QRScannerProApp extends StatelessWidget {
  const QRScannerProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
