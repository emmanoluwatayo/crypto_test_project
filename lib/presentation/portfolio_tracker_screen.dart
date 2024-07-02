import 'package:crypto_test_project/riverpod_repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortfolioTrackerScreen extends ConsumerWidget {
  final TextEditingController _coinIdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  PortfolioTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(portfolioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio Tracker')),
      body: Column(
        children: [
          TextField(
            controller: _coinIdController,
            decoration: const InputDecoration(labelText: 'Coin ID'),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              final coinId = _coinIdController.text;
              final quantity = double.tryParse(_quantityController.text) ?? 0.0;
              ref
                  .read(portfolioProvider.notifier)
                  .addEntry(PortfolioEntry(coinId, quantity));
              _coinIdController.clear();
              _quantityController.clear();
            },
            child: const Text('Add to Portfolio'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: portfolio.length,
              itemBuilder: (context, index) {
                final entry = portfolio[index];
                return ListTile(
                  title: Text(entry.coinId),
                  subtitle: Text('Quantity: ${entry.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(portfolioProvider.notifier).removeEntry(entry);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
