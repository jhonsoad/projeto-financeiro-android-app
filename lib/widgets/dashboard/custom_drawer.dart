import 'package:flutter/material.dart';
import 'package:projeto_financeiro/routes.dart';

enum DashboardPage { inicio, transferencias, investimentos, servicos }

class CustomDrawer extends StatelessWidget {
  final DashboardPage currentPage;
  final Function(DashboardPage) onPageSelected;

  const CustomDrawer({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1E3A44), // Cor de fundo do drawer
        child: ListView(
          padding: const EdgeInsets.only(
            top: 40,
            left: 16,
            right: 16,
          ),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 20),
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Início',
              isSelected: currentPage == DashboardPage.inicio,
              onTap: () => onPageSelected(DashboardPage.inicio),
            ),
            _buildDrawerItem(
              icon: Icons.swap_horiz,
              title: 'Transferências',
              isSelected: currentPage == DashboardPage.transferencias,
              onTap: () =>
                  onPageSelected(DashboardPage.transferencias),
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Investimentos',
              isSelected: currentPage == DashboardPage.investimentos,
              onTap: () =>
                  onPageSelected(DashboardPage.investimentos),
            ),
            _buildDrawerItem(
              icon: Icons.grid_view_sharp,
              title: 'Outros serviços',
              isSelected: currentPage == DashboardPage.servicos,
              onTap: () => onPageSelected(DashboardPage.servicos),
            ),
            const Divider(
              color: Colors.white54,
              thickness: 1,
              height: 30,
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Sair',
              isSelected: false,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.home,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFFD95236) : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFFD95236) : Colors.white,
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.normal,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }
}
