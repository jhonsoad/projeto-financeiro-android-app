import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
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
              title: 'Início',
              isSelected: currentPage == DashboardPage.inicio,
              onTap: () => onPageSelected(DashboardPage.inicio),
            ),
            _buildDrawerItem(
              title: 'Transferências',
              isSelected: currentPage == DashboardPage.transferencias,
              onTap: () => onPageSelected(DashboardPage.transferencias),
            ),
            _buildDrawerItem(
              title: 'Investimentos',
              isSelected: currentPage == DashboardPage.investimentos,
              onTap: () => onPageSelected(DashboardPage.investimentos),
            ),
            _buildDrawerItem(
              title: 'Outros serviços',
              isSelected: currentPage == DashboardPage.servicos,
              onTap: () => onPageSelected(DashboardPage.servicos),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFFD95236) : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }
}