import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/portfolio_model.dart';

class LocalStorage {
  static const String _key = 'portfolio_data';

  Future<void> savePortfolio(List<PortfolioItem> portfolio) async {
    final prefs = await SharedPreferences.getInstance();
    final data = portfolio.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(data));
  }

  Future<List<PortfolioItem>> loadPortfolio() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => PortfolioItem.fromJson(e)).toList();
  }
}
