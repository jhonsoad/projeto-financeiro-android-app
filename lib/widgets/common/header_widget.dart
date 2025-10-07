import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodyMedium?.copyWith(color: Colors.white);

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 48.0,
        runSpacing: 24.0,
        children: [
          _buildFooterColumn(
            context,
            title: 'Serviços',
            children: [
              Text('Conta corrente', style: textTheme),
              Text('Conta PJ', style: textTheme),
              Text('Cartão de crédito', style: textTheme),
            ],
          ),
          _buildFooterColumn(
            context,
            title: 'Contato',
            children: [
              Text('0800 004 250 08', style: textTheme),
              Text('meajuda@bytebank.com.br', style: textTheme),
              Text('ouvidoria@bytebank.com.br', style: textTheme),
            ],
          ),
          _buildFooterColumn(
            context,
            title: 'Desenvolvido por Alura',
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo-branco.svg',
                height: 32,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/instagram.svg', height: 29),
                  const SizedBox(width: 16),
                  SvgPicture.asset('assets/icons/whatsapp.svg', height: 29),
                  const SizedBox(width: 16),
                  SvgPicture.asset('assets/icons/youtube.svg', height: 29),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFooterColumn(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...children.map((child) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: child,
            )),
      ],
    );
  }
}