// lib/widgets/dashboard/services_section.dart
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nova transação',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildServiceButton(Icons.account_balance_wallet, 'Empréstimo'),
            _buildServiceButton(Icons.credit_card, 'Meus cartões'),
            _buildServiceButton(Icons.favorite, 'Doações'),
            _buildServiceButton(Icons.pix, 'Pix'),
            _buildServiceButton(Icons.shield, 'Seguros'),
            _buildServiceButton(Icons.phone_android, 'Crédito celular'),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceButton(IconData icon, String label) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.green),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}