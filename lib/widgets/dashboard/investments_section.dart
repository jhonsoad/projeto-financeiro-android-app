import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/transaction.dart';

class InvestmentsSection extends StatelessWidget {
  final List<Transaction> transactions;

  const InvestmentsSection({super.key, this.transactions = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInvestmentCard(
          context: context,
          title: 'Investimentos',
          total: 'R\$ 50.000,00',
          items: {
            'Renda Fixa': 'R\$ 36.000,00',
            'Renda Variável': 'R\$ 14.000,00',
          },
        ),
        const SizedBox(height: 24),
        _buildStatsCard(context),
      ],
    );
  }

  Widget _buildInvestmentCard({
    required BuildContext context,
    required String title,
    required String total,
    required Map<String, String> items,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Total: $total',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...items.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C5B6C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final Map<String, double> spendingByCategory = {};
    for (var transaction in transactions) {
      if (transaction.amount < 0) {
        spendingByCategory.update(
          transaction.type,
          (value) => value + transaction.amount.abs(),
          ifAbsent: () => transaction.amount.abs(),
        );
      }
    }

    final List<PieChartSectionData>
    pieChartSections = spendingByCategory.entries.map((entry) {
      final isTouched = false;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: _getColorForCategory(entry.key),
        value: entry.value,
        title:
            '${(entry.value / spendingByCategory.values.reduce((a, b) => a + b) * 100).toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    }).toList();

    return Card(
      color: const Color(0xFF2C5B6C),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Estatísticas',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: pieChartSections,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildLegend(context),
          ],
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Depósito':
        return Colors.blue;
      case 'Transferência':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend(BuildContext context) {
    return Column(
      children: [
        _legendItem(Colors.blue, 'Depósito'),
        _legendItem(Colors.purple, 'Transferência'),
        _legendItem(Colors.orange, 'Previdência Privada'),
        _legendItem(Colors.red, 'Bolsa de Valores'),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
