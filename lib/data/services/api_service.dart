import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<dynamic>> fetchCoinsList() async {
    final response = await http.get(Uri.parse('$baseUrl/coins/list'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load coins');
    }
  }

  Future<Map<String, dynamic>> fetchPrices(List<String> ids) async {
    final joinedIds = ids.join(',');
    final response = await http.get(
      Uri.parse('$baseUrl/simple/price?ids=$joinedIds&vs_currencies=usd'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch prices');
    }
  }
  Future<Map<String, dynamic>> fetchCoinDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/coins/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'name': data['name'],
        'symbol': data['symbol'],
        'logo': data['image']['thumb'],
      };
    } else {
      throw Exception('Failed to load coin details');
    }
  }

}
