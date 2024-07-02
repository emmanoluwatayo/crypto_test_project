// ignore_for_file: library_private_types_in_public_api

import 'package:crypto_test_project/riverpod_repo/market_data_repo.dart';
import 'package:crypto_test_project/riverpod_repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  String _sortAttribute = 'name';
  bool _ascending = true;

  @override
  Widget build(BuildContext context) {
    final portfolio = ref.watch(portfolioProvider);
    final marketData = ref.watch(marketDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Portfolio')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: _sortAttribute,
            onChanged: (value) {
              setState(() {
                _sortAttribute = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Name')),
              DropdownMenuItem(value: 'price', child: Text('Price')),
              DropdownMenuItem(value: 'change', child: Text('24h Change')),
            ],
          ),
          SwitchListTile(
            title: const Text('Ascending'),
            value: _ascending,
            onChanged: (value) {
              setState(() {
                _ascending = value;
              });
            },
          ),
          Expanded(
            child: marketData.when(
              data: (data) {
                List<PortfolioEntry> sortedPortfolio = [...portfolio];
                sortedPortfolio.sort((a, b) {
                  final coinA =
                      data.firstWhere((coin) => coin['id'] == a.coinId);
                  final coinB =
                      data.firstWhere((coin) => coin['id'] == b.coinId);

                  switch (_sortAttribute) {
                    case 'price':
                      return _ascending
                          ? coinA['current_price']
                              .compareTo(coinB['current_price'])
                          : coinB['current_price']
                              .compareTo(coinA['current_price']);
                    case 'change':
                      return _ascending
                          ? coinA['price_change_percentage_24h']
                              .compareTo(coinB['price_change_percentage_24h'])
                          : coinB['price_change_percentage_24h']
                              .compareTo(coinA['price_change_percentage_24h']);
                    case 'name':
                    default:
                      return _ascending
                          ? coinA['name'].compareTo(coinB['name'])
                          : coinB['name'].compareTo(coinA['name']);
                  }
                });

                double totalValue = 0.0;
                for (var entry in sortedPortfolio) {
                  final coin =
                      data.firstWhere((coin) => coin['id'] == entry.coinId);
                  totalValue += coin['current_price'] * entry.quantity;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        'Total Portfolio Value: \$${totalValue.toStringAsFixed(2)}'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sortedPortfolio.length,
                        itemBuilder: (context, index) {
                          final entry = sortedPortfolio[index];
                          final coin = data
                              .firstWhere((coin) => coin['id'] == entry.coinId);
                          return ListTile(
                            title: Text(coin['name']),
                            subtitle: Text(
                                'Price: \$${coin['current_price']} | 24h Change: ${coin['price_change_percentage_24h']}%'),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => const Text('Error loading market data'),
            ),
          ),
        ],
      ),
    );
  }
}
