import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../utils/local_storage.dart';
import '../widgets/dashboard/balance_card.dart';
import '../widgets/dashboard/custom_drawer.dart';
import '../widgets/dashboard/investments_section.dart';
import '../widgets/dashboard/my_cards_section.dart';
import '../widgets/dashboard/new_transaction_form.dart';
import '../widgets/dashboard/services_section.dart';
import '../widgets/dashboard/statement_card.dart';

const double initialBaseBalance = 2500.00;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  List<Transaction> _transactions = [];
  double _balance = initialBaseBalance;
  bool _isLoading = false;
  DashboardPage _currentPage = DashboardPage.inicio;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final storedTransactions = await LocalStorage.loadTransactions();
    setState(() {
      _transactions = storedTransactions;
      _calculateTotalBalance(storedTransactions);
      _isLoading = false;
    });
  }

  void _calculateTotalBalance(List<Transaction> currentTransactions) {
    final total = currentTransactions.fold(
      initialBaseBalance,
      (sum, item) => sum + item.amount,
    );
    setState(() {
      _balance = total;
    });
  }

  void _addTransaction(String type, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      amount: amount,
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );

    setState(() {
      _transactions.insert(0, newTransaction);
    });

    LocalStorage.saveTransactions(_transactions);
    _calculateTotalBalance(_transactions);
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
    LocalStorage.saveTransactions(_transactions);
    _calculateTotalBalance(_transactions);
  }

  void _editTransaction(Transaction updatedTransaction) {
    setState(() {
      final index = _transactions.indexWhere(
        (tx) => tx.id == updatedTransaction.id,
      );
      if (index != -1) {
        _transactions[index] = updatedTransaction;
      }
    });
    LocalStorage.saveTransactions(_transactions);
    _calculateTotalBalance(_transactions);
  }

  void _onPageSelected(DashboardPage page) {
    setState(() {
      _currentPage = page;
    });
    Navigator.of(context).pop(); // Fecha o drawer após a seleção
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case DashboardPage.inicio:
        return Column(
          children: [
            const MyCardsSection(),
            const SizedBox(height: 24),
            StatementCard(
              transactions: _transactions,
              onDelete: _deleteTransaction,
              onEdit: _editTransaction,
            ),
          ],
        );
      case DashboardPage.transferencias:
        return Column(
          children: [
            NewTransactionForm(onAddTransaction: _addTransaction),
            const SizedBox(height: 24),
            StatementCard(
              transactions: _transactions,
              onDelete: _deleteTransaction,
              onEdit: _editTransaction,
            ),
          ],
        );
      case DashboardPage.investimentos:
        return const InvestmentsSection();
      case DashboardPage.servicos:
        return const ServicesSection();
      default:
        return const MyCardsSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        currentPage: _currentPage,
        onPageSelected: _onPageSelected,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Olá, Joana! :)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Ação do perfil
            },
          ),
        ],
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BalanceCard(balance: _balance),
                  const SizedBox(height: 24),
                  _buildCurrentPage(),
                ],
              ),
            ),
    );
  }
}
