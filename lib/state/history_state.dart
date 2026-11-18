import 'package:flutter/foundation.dart';
import 'package:qr_scanner_pro/core/services/storage_services.dart';

import '../core/constants/app_constants.dart';
import '../models/qr_history_model.dart';

class HistoryState extends ChangeNotifier {
  List<QRHistoryModel> _history = [];

  bool _isLoading = false;

  List<QRHistoryModel> get history => List.unmodifiable(_history);

  bool get isLoading => _isLoading;

  List<QRHistoryModel> get scannedHistory =>
      _history.where((item) => item.type == 'scanned').toList();

  List<QRHistoryModel> get generatedHistory =>
      _history.where((item) => item.type == 'generated').toList();

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _history = await StorageService.getHistory();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHistory({
    required String content,
    required String type,
  }) async {
    if (content.trim().isEmpty) return;

    final item = QRHistoryModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      content: content.trim(),
      type: type,
      createdAt: DateTime.now(),
    );

    _history.insert(0, item);

    if (_history.length > AppConstants.maxHistoryItems) {
      _history = _history.take(AppConstants.maxHistoryItems).toList();
    }

    notifyListeners();

    await StorageService.saveHistory(_history);
  }

  Future<void> deleteHistory(String id) async {
    _history.removeWhere((item) => item.id == id);

    notifyListeners();

    await StorageService.saveHistory(_history);
  }

  Future<void> clearHistory() async {
    _history.clear();

    notifyListeners();

    await StorageService.clearHistory();
  }
}
