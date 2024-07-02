import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../api_service/api_service.dart';
import '../model/crypto_model.dart';

final cryptoServiceProvider = Provider((ref) => CryptoService());

final portfolioProvider = StateNotifierProvider<PortfolioNotifier, List<Crypto>>((ref) {
  return PortfolioNotifier();
});

class PortfolioNotifier extends StateNotifier<List<Crypto>> {
  PortfolioNotifier() : super([]) {
    loadPortfolio();
  }

  void addCrypto(Crypto crypto) {
    state = [...state, crypto];
    savePortfolio();
  }

  void removeCrypto(String id) {
    state = state.where((crypto) => crypto.id != id).toList();
    savePortfolio();
  }

  void savePortfolio() {
    final box = Hive.box<Crypto>('portfolio');
    box.clear(); // Clear the box before saving the updated list
    for (var crypto in state) {
      box.put(crypto.id, crypto);
    }
  }

  void loadPortfolio() {
    final box = Hive.box<Crypto>('portfolio');
    state = box.values.toList().cast<Crypto>();
  }
}
