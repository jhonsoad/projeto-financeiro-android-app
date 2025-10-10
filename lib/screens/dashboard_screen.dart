import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/dashboard/balance_card.dart';
import '../widgets/dashboard/custom_drawer.dart';
import '../widgets/dashboard/filter_selection.dart';
import '../widgets/dashboard/investments_section.dart';
import '../widgets/dashboard/my_cards_section.dart';
import '../widgets/dashboard/new_transaction_form.dart';
import '../widgets/dashboard/services_section.dart';
import '../widgets/dashboard/statement_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  DashboardPage _currentPage = DashboardPage.inicio;
  final TextEditingController _dateController =
      TextEditingController();
  String _userName = '';
  String? _selectedCategoryFilter;
  DateTime? _selectedDateFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(
        context,
        listen: false,
      ).loadTransactions();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<TransactionProvider>().loadMoreTransactions(
          category: _selectedCategoryFilter,
          date: _selectedDateFilter,
        );
      }
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _selectedCategoryFilter = null;
      _selectedDateFilter = null;
      _dateController.clear();
    });
    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).loadTransactions();
  }

  void _onPageSelected(DashboardPage page) {
    setState(() {
      _currentPage = page;
    });
    Navigator.of(context).pop();
  }

  Widget _buildCurrentPage(TransactionProvider provider) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: switch (_currentPage) {
        DashboardPage.inicio => Column(
          key: const ValueKey('InicioPage'),
          children: [
            const MyCardsSection(),
            const SizedBox(height: 24),
            FilterSection(
              selectedCategory: _selectedCategoryFilter,
              dateController: _dateController,
              onCategoryChanged: (category) {
                setState(() => _selectedCategoryFilter = category);
                provider.loadTransactions(
                  category: category,
                  date: _selectedDateFilter,
                );
              },
              onDateChanged: (date) {
                if (date != null) {
                  setState(() {
                    _selectedDateFilter = date;
                    _dateController.text = DateFormat(
                      'dd/MM/yyyy',
                    ).format(date);
                  });
                  provider.loadTransactions(
                    category: _selectedCategoryFilter,
                    date: date,
                  );
                }
              },
              onFilterCleared: _clearFilters,
            ),
            const SizedBox(height: 24),
            // Os dados e funções agora são lidos do provider dentro do próprio widget
            const StatementCard(),
          ],
        ),
        DashboardPage.transferencias => Column(
          key: const ValueKey('TransferenciasPage'),
          children: [
            NewTransactionForm(
              onAddTransaction: (type, amount, proof) {
                context.read<TransactionProvider>().addTransaction(
                  type,
                  amount,
                  proof,
                );
              },
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            const StatementCard(),
          ],
        ),
        DashboardPage.investimentos => InvestmentsSection(
          key: const ValueKey('InvestimentosPage'),
          transactions: provider.transactions,
        ),
        DashboardPage.servicos => const ServicesSection(
          key: ValueKey('ServicosPage'),
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(
            currentPage: _currentPage,
            onPageSelected: _onPageSelected,
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () =>
                  _scaffoldKey.currentState?.openDrawer(),
            ),
            title: Text('Olá, $_userName! :)'),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {},
              ),
            ],
            elevation: 0,
          ),
          body:
              (transactionProvider.isLoading &&
                  transactionProvider.transactions.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BalanceCard(
                        balance: transactionProvider.balance,
                        userName: _userName,
                      ),
                      const SizedBox(height: 24),
                      _buildCurrentPage(transactionProvider),
                      if (transactionProvider.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
