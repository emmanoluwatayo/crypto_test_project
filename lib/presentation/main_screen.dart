// screens/main_screen.dart
import 'package:crypto_test_project/presentation/add_cryptocurrencies.dart';
import 'package:crypto_test_project/presentation/portfolio_chart_screen.dart';
import 'package:crypto_test_project/riverpod_repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(portfolioProvider);

    double totalValue = portfolio.fold(
      0,
      (sum, crypto) => sum + (crypto.quantity * 100),
    ); // Placeholder price

    return Scaffold(
      appBar: AppBar(title: Text('Crypto Portfolio')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Portfolio Value: \$${totalValue.toStringAsFixed(2)} USD',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: PortfolioChart(portfolio: portfolio)),
          Expanded(
            child: ListView.builder(
              itemCount: portfolio.length,
              itemBuilder: (context, index) {
                final crypto = portfolio[index];
                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text('Quantity: ${crypto.quantity}'),
                  trailing: Text('Price: \$100'), // Placeholder price
                  onLongPress: () {
                    ref
                        .read(portfolioProvider.notifier)
                        .removeCrypto(crypto.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddCryptoScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
