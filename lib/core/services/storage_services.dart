import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/qr_history_model.dart';
import '../constants/app_constants.dart';

class StorageService {
  StorageService._();

  static Future<List<QRHistoryModel>> getHistory() async {
    final preferences = await SharedPreferences.getInstance();

    final storedData = preferences.getString(AppConstants.historyStorageKey);

    if (storedData == null || storedData.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decodedData = jsonDecode(storedData);

      return decodedData
          .map(
            (item) => QRHistoryModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<bool> saveHistory(List<QRHistoryModel> history) async {
    final preferences = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(
      history.map((item) => item.toJson()).toList(),
    );

    return preferences.setString(AppConstants.historyStorageKey, encodedData);
  }

  static Future<bool> clearHistory() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.remove(AppConstants.historyStorageKey);
  }
}
