import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: 24.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFooterColumn('Serviços', [
                'Conta corrente',
                'Conta PJ',
                'Cartão de crédito',
              ]),
              _buildFooterColumn('Contato', [
                '0800 004 250 08',
                'meajuda@bytebank.com.br',
                'ouvidoria@bytebank.com.br',
              ]),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Desenvolvido por Alura',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 20),
          SvgPicture.asset(
            'assets/icons/logo.svg',
            height: 30,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon('assets/icons/instagram.svg'),
              const SizedBox(width: 24),
              _buildSocialIcon('assets/icons/whatsapp.svg'),
              const SizedBox(width: 24),
              _buildSocialIcon('assets/icons/youtube.svg'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildFooterColumn(String title, List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 12),
      ...items.map(
        (item) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            item,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSocialIcon(String assetName) {
  return SvgPicture.asset(
    assetName,
    height: 24,
    colorFilter: const ColorFilter.mode(
      Colors.white,
      BlendMode.srcIn,
    ),
  );
}
