import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction_provider.dart';
import '../../models/transaction.dart';
import '../common/custom_button.dart';
import '../common/custom_input.dart';
import '../common/custom_modal.dart';

class StatementCard extends StatelessWidget {
  const StatementCard({super.key});

  String _getMonthName(String dateString, BuildContext context) {
    try {
      final date = DateFormat('dd/MM/yyyy').parse(dateString);
      // 'MMMM' para o nome completo do mês
      final monthName = DateFormat('MMMM', 'pt_BR').format(date);
      return monthName[0].toUpperCase() + monthName.substring(1);
    } catch (e) {
      return "Data inválida";
    }
  }

  void _showEditModal(BuildContext context, Transaction transaction) {
    final valueController = TextEditingController(
      text: transaction.amount
          .abs()
          .toStringAsFixed(2)
          .replaceAll('.', ','),
    );

    showCustomModal(
      context: context,
      title: 'Editar Transação',
      content: CustomInput(
        label: 'Valor',
        controller: valueController,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
      ),
      actions: [
        CustomButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Cancelar',
          variant: ButtonVariant.outline,
        ),
        CustomButton(
          onPressed: () {
            final valueText = valueController.text.replaceAll(
              ',',
              '.',
            );
            final newAmount = double.tryParse(valueText);
            if (newAmount != null) {
              final finalAmount = transaction.type == 'Transferência'
                  ? -newAmount
                  : newAmount;
              final updatedTransaction = Transaction(
                id: transaction.id,
                type: transaction.type,
                amount: finalAmount,
                date: transaction.date,
                proof: transaction.proof,
                userId: transaction.userId,
              );
              context.read<TransactionProvider>().editTransaction(
                updatedTransaction,
              );
              Navigator.of(context).pop();
            }
          },
          text: 'Salvar',
          variant: ButtonVariant.primary,
        ),
      ],
    );
  }

  void _showDeleteConfirmationModal(
    BuildContext context,
    Transaction transaction,
  ) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    showCustomModal(
      context: context,
      title: 'Confirmar Exclusão',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Você tem certeza que deseja deletar a seguinte transação?',
          ),
          const SizedBox(height: 16),
          Text(
            'Tipo: ${transaction.type}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Valor: ${currencyFormatter.format(transaction.amount)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Data: ${transaction.date}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        CustomButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Cancelar',
          variant: ButtonVariant.outline,
        ),
        CustomButton(
          onPressed: () {
            context.read<TransactionProvider>().deleteTransaction(
              transaction.id,
            );
            Navigator.of(context).pop();
          },
          text: 'Excluir',
          variant: ButtonVariant.danger,
        ),
      ],
    );
  }

  void _showProofModal(BuildContext context, String proofUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.network(proofUrl),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    final transactionProvider = context.watch<TransactionProvider>();
    final transactions = transactionProvider.transactions;

    return Card(
      color: theme.colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Extrato', style: theme.textTheme.displayMedium),
            const Divider(),
            const SizedBox(height: 16),
            if (transactions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('Nenhuma transação encontrada.'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = transactions[index];
                  final isNegative = item.amount < 0;
                  final amountColor = isNegative
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.onSurface;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMonthName(item.date, context),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF47A138),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.type,
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            item.date,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            currencyFormatter.format(item.amount),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: amountColor,
                                ),
                          ),
                          const Spacer(),
                          if (item.proof != null)
                            IconButton(
                              onPressed: () => _showProofModal(
                                context,
                                item.proof!,
                              ),
                              icon: const Icon(Icons.receipt),
                              tooltip: 'Ver Comprovante',
                            ),
                          IconButton(
                            onPressed: () =>
                                _showEditModal(context, item),
                            icon: SvgPicture.asset(
                              'assets/icons/icon-edit.svg',
                              height: 20,
                            ),
                            tooltip: 'Editar transação',
                          ),
                          IconButton(
                            onPressed: () =>
                                _showDeleteConfirmationModal(
                                  context,
                                  item,
                                ),
                            icon: SvgPicture.asset(
                              'assets/icons/icon-trash.svg',
                              height: 20,
                            ),
                            tooltip: 'Deletar transação',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Color(0x8047A138)),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
