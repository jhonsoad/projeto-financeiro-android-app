// lib/widgets/dashboard/my_cards_section.dart
import 'package:flutter/material.dart';

class MyCardsSection extends StatelessWidget {
  const MyCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meus Cartões',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildCard(
          context,
          title: 'Byte Platinum',
          subtitle: 'Joana F. Oliveira',
          cardNumber: '**** **** **** 1234',
          label: 'Cartão físico',
          function: 'Função: débito/crédito',
          isDigital: false,
        ),
        const SizedBox(height: 16),
        _buildCard(
          context,
          title: 'Byte Platinum',
          subtitle: 'Joana F. Oliveira',
          cardNumber: '**** **** **** 5678',
          label: 'Cartão digital',
          function: 'Função: Débito',
          isDigital: true,
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String cardNumber,
    required String label,
    required String function,
    required bool isDigital,
  }) {
    final cardColor = isDigital ? Colors.grey[700] : const Color(0xFF2C5B6C);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text(cardNumber, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: () {}, child: const Text('Configurar')),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(onPressed: () {}, child: const Text('Bloquear')),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(child: Text(function)),
          ],
        ),
      ),
    );
  }
}