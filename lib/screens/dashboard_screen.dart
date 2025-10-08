import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    hide Transaction;
import 'package:intl/intl.dart';
import '../models/transaction.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    final snapshot = await _firestore
        .collection('transactions')
        .get();
    final transactions = snapshot.docs
        .map((doc) => Transaction.fromJson(doc.data()))
        .toList();
    setState(() {
      _transactions = transactions;
      _calculateTotalBalance(transactions);
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

  void _addTransaction(String type, double amount, String? proof) {
    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      amount: amount,
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      proof: proof,
    );

    _firestore
        .collection('transactions')
        .doc(newTransaction.id)
        .set(newTransaction.toJson());

    setState(() {
      _transactions.insert(0, newTransaction);
    });

    _calculateTotalBalance(_transactions);
  }

  void _deleteTransaction(String id) {
    _firestore.collection('transactions').doc(id).delete();
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
    _calculateTotalBalance(_transactions);
  }

  void _editTransaction(Transaction updatedTransaction) {
    _firestore
        .collection('transactions')
        .doc(updatedTransaction.id)
        .update(updatedTransaction.toJson());
    setState(() {
      final index = _transactions.indexWhere(
        (tx) => tx.id == updatedTransaction.id,
      );
      if (index != -1) {
        _transactions[index] = updatedTransaction;
      }
    });
    _calculateTotalBalance(_transactions);
  }

  void _onPageSelected(DashboardPage page) {
    setState(() {
      _currentPage = page;
    });
    Navigator.of(context).pop(); // Fecha o drawer após a seleção
  }

  Widget _buildCurrentPage() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: switch (_currentPage) {
        DashboardPage.inicio => Column(
          key: const ValueKey(
            'InicioPage',
          ),
          children: [
            const MyCardsSection(),
            const SizedBox(height: 24),
            StatementCard(
              transactions: _transactions,
              onDelete: _deleteTransaction,
              onEdit: _editTransaction,
            ),
          ],
        ),
        DashboardPage.transferencias => Column(
          key: const ValueKey(
            'TransferenciasPage',
          ),
          children: [
            NewTransactionForm(onAddTransaction: _addTransaction),
            const SizedBox(height: 24),
            StatementCard(
              transactions: _transactions,
              onDelete: _deleteTransaction,
              onEdit: _editTransaction,
            ),
          ],
        ),
        DashboardPage.investimentos => const InvestmentsSection(
          key: ValueKey(
            'InvestimentosPage',
          ), 
        ),
        DashboardPage.servicos => const ServicesSection(
          key: ValueKey('ServicosPage'), // Adiciona uma chave única
        ),
      },
    );
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
