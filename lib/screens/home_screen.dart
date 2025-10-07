import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_financeiro/routes.dart';

import '../theme/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/home/advantage_card.dart';
import '../widgets/home/footer_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = 80.0;
    final ButtonStyle? buttonStyle = Theme.of(
      context,
    ).elevatedButtonTheme.style;
    final Color? iconColor = buttonStyle?.backgroundColor?.resolve(
      {},
    );

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Página Inicial'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.menu,
                  color: iconColor,
                ), // Ícone de hambúrguer
                onPressed: () {
                  // Comando para abrir o Drawer
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                height: 30,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(context),
              _buildAdvantagesSection(context),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Experimente mais liberdade no controle da sua vida financeira. Crie sua conta com a gente!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          SvgPicture.asset(
            'assets/images/illustration.svg',
            width: 350,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.register);
                },
                text: 'Abrir conta',
                variant: ButtonVariant.primary,
              ),
              const SizedBox(width: 24),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                text: 'Já tenho conta',
                variant: ButtonVariant.outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantagesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 0,
      ),
      child: Column(
        children: [
          const Text(
            'Vantagens do nosso banco:',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          const Wrap(
            spacing: 48.0,
            runSpacing: 48.0,
            alignment: WrapAlignment.center,
            children: [
              AdvantageCard(
                iconSrc: 'assets/icons/icon-gift.svg',
                title: 'Conta e cartão gratuitos',
                description:
                    'Isso mesmo, nossa conta é digital, sem custo fixo e você não tem tarifa de manutenção.',
              ),
              AdvantageCard(
                iconSrc: 'assets/icons/icon-money.svg',
                title: 'Saques sem custo',
                description:
                    'Você pode sacar gratuitamente 4x por mês de qualquer banco 24h.',
              ),
              AdvantageCard(
                iconSrc: 'assets/icons/icon-star.svg',
                title: 'Programa de pontos',
                description:
                    'Você pode acumular pontos com suas compras no crédito sem pagar mensalidade!',
              ),
              AdvantageCard(
                iconSrc: 'assets/icons/icon-shield.svg',
                title: 'Seguro Dispositivos',
                description:
                    'Seus dispositivos móveis (computadores, celulares) protegidos por uma mensalidade simbólica.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
