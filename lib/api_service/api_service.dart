import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final cryptoApiProvider = Provider((ref) => CryptoApi());

class CryptoApi {
  Future<List<Map<String, dynamic>>> fetchMarketData() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      throw Exception('Failed to load market data');
    }
  }

  Future<Map<String, dynamic>> fetchCoinData(String coinId) async {
    final response = await http
        .get(Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId'));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      throw Exception('Failed to load coin data');
    }
  }
}
