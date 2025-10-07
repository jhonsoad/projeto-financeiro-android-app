// lib/widgets/common/advantage_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdvantageCard extends StatelessWidget {
  final String iconSrc;
  final String title;
  final String description;

  const AdvantageCard({
    super.key,
    required this.iconSrc,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        children: [
          SvgPicture.asset(
            iconSrc,
            height: 40,
            colorFilter: const ColorFilter.mode(
              Color(0xFF20C979), // Verde do Bytebank
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20C979), // Verde do Bytebank
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}