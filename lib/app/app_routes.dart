
import 'package:flutter/material.dart';
import 'package:qr_scanner_pro/screens/generator/generator_screen.dart';
import 'package:qr_scanner_pro/screens/history/history_screen.dart';
import 'package:qr_scanner_pro/screens/scanner/scanner_screen.dart';

import '../screens/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String scanner = '/scanner';
  static const String generator = '/generator';
  static const String history = '/history';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => HomeScreen(
              onScanTap: () {
                Navigator.pushNamed(context, scanner);
              },
              onGenerateTap: () {
                Navigator.pushNamed(context, generator);
              },
              onHistoryTap: () {
                Navigator.pushNamed(context, history);
              },
            ),

        scanner: (context) => const ScannerScreen(),

        generator: (context) => const GeneratorScreen(),

        history: (context) => const HistoryScreen(),
            
      };
}

class TemporaryPage extends StatelessWidget {
  final String title;

  const TemporaryPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
