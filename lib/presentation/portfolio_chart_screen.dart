// widgets/portfolio_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/crypto_model.dart';

class PortfolioChart extends StatelessWidget {
  final List<Crypto> portfolio;

  const PortfolioChart({
    super.key,
    required this.portfolio,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: portfolio.map((crypto) {
          final value = crypto.quantity * 100; // Placeholder price
          return PieChartSectionData(
            value: value,
            title: crypto.name,
            color: Colors
                .primaries[portfolio.indexOf(crypto) % Colors.primaries.length],
          );
        }).toList(),
      ),
    );
  }
}
