import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class LocalStorage {
  static const _key = 'transactions';

  static Future<List<Transaction>> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serializedTransactions = prefs.getString(_key);
      if (serializedTransactions == null) {
        return [];
      }
      final List<dynamic> jsonData = json.decode(serializedTransactions);
      return jsonData.map((item) => Transaction.fromJson(item)).toList();
    } catch (e) {
      print("Error loading transactions: $e");
      return [];
    }
  }

  static Future<void> saveTransactions(List<Transaction> transactions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonData =
          transactions.map((t) => t.toJson()).toList();
      await prefs.setString(_key, json.encode(jsonData));
    } catch (e) {
      print("Error saving transactions: $e");
    }
  }
}