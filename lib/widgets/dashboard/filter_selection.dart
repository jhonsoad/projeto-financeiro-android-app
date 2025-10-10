import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final Function(String? category) onCategoryChanged;
  final Function(DateTime? date) onDateChanged;
  final VoidCallback onFilterCleared;

  final String? selectedCategory;
  final TextEditingController dateController;

  const FilterSection({
    super.key,
    required this.onCategoryChanged,
    required this.onDateChanged,
    required this.onFilterCleared,
    this.selectedCategory,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                DropdownButtonFormField<String>(
                  value:
                      selectedCategory,
                  hint: const Text('Categoria'),
                  onChanged:
                      onCategoryChanged,
                  items: ['Depósito', 'Transferência']
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                ),
                TextFormField(
                  controller:
                      dateController,
                  decoration: const InputDecoration(
                    hintText: 'Data (dd/MM/yyyy)',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    onDateChanged(pickedDate);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  onFilterCleared,
              child: const Text('Limpar Filtros'),
            ),
          ],
        ),
      ),
    );
  }
}
