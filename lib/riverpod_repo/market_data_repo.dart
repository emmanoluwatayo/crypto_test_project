import 'package:crypto_test_project/api_service/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final marketDataProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final cryptoApi = ref.watch(cryptoApiProvider);
  return cryptoApi.fetchMarketData();
});

final coinDataProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, coinId) async {
  final cryptoApi = ref.watch(cryptoApiProvider);
  return cryptoApi.fetchCoinData(coinId);
});
