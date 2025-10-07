// lib/widgets/dashboard/investments_section.dart
import 'package:flutter/material.dart';

class InvestmentsSection extends StatelessWidget {
  const InvestmentsSection({super.key});

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

  Widget _buildInvestmentCard(
      {required BuildContext context,
      required String title,
      required String total,
      required Map<String, String> items}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Total: $total', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ...items.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF2C5B6C),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: const TextStyle(color: Colors.white)),
                        Text(entry.value,
                            style:
                                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Card(
      color: const Color(0xFF2C5B6C),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Estatísticas',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white)),
            const SizedBox(height: 24),
            // Placeholder for the chart
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Text('Chart'), // Replace with a real chart widget
            ),
            const SizedBox(height: 24),
            _buildLegend(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Column(
      children: [
        _legendItem(Colors.blue, 'Fundos de investimento'),
        _legendItem(Colors.purple, 'Tesouro Direto'),
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