// services/crypto_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String apiUrl = 'https://api.coingecko.com/api/v3';

  Future<Map<String, dynamic>> fetchCoinData(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/coins/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load coin data');
    }
  }

  Future<List<dynamic>> fetchCoinList() async {
    final response = await http.get(Uri.parse('$apiUrl/coins/markets?vs_currency=usd'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load coin list');
    }
  }
}
