import 'package:flutter_riverpod/flutter_riverpod.dart';

final portfolioProvider = StateNotifierProvider<PortfolioNotifier, List<PortfolioEntry>>((ref) => PortfolioNotifier());

class PortfolioEntry {
  final String coinId;
  final double quantity;

  PortfolioEntry(this.coinId, this.quantity);
}

class PortfolioNotifier extends StateNotifier<List<PortfolioEntry>> {
  PortfolioNotifier() : super([]);

  void addEntry(PortfolioEntry entry) {
    state = [...state, entry];
  }

  void removeEntry(PortfolioEntry entry) {
    state = state.where((e) => e.coinId != entry.coinId).toList();
  }
}
