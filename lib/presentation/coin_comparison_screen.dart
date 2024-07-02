import 'package:crypto_test_project/riverpod_repo/market_data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinComparisonScreen extends ConsumerWidget {
  final TextEditingController _coinId1Controller = TextEditingController();
  final TextEditingController _coinId2Controller = TextEditingController();

  CoinComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Comparison')),
      body: Column(
        children: [
          TextField(
            controller: _coinId1Controller,
            decoration: const InputDecoration(labelText: 'First Coin ID'),
          ),
          TextField(
            controller: _coinId2Controller,
            decoration: const InputDecoration(labelText: 'Second Coin ID'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.refresh(coinDataProvider(_coinId1Controller.text));
              ref.refresh(coinDataProvider(_coinId2Controller.text));
            },
            child: const Text('Compare'),
          ),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final coin1Data =
                  ref.watch(coinDataProvider(_coinId1Controller.text));
              final coin2Data =
                  ref.watch(coinDataProvider(_coinId2Controller.text));

              return coin1Data.when(
                data: (coin1) {
                  return coin2Data.when(
                    data: (coin2) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCoinDetails(context, coin1),
                          _buildCoinDetails(context, coin2),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => const Text('Error loading data'),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => const Text('Error loading data'),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinDetails(
      BuildContext context, Map<String, dynamic> coinData) {
    final prices =
        List<double>.from(coinData['market_data']['sparkline_7d']['price']);

    return Column(
      children: [
        Text('Price: \$${coinData['market_data']['current_price']['usd']}'),
        Text('Market Cap: \$${coinData['market_data']['market_cap']['usd']}'),
        Text('Volume: \$${coinData['market_data']['total_volume']['usd']}'),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    prices.length,
                    (index) => FlSpot(index.toDouble(), prices[index]),
                  ),
                  isCurved: true,
                  barWidth: 2,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
