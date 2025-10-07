import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../common/custom_button.dart';
import '../common/custom_dropdown.dart';
import '../common/custom_input.dart';

class NewTransactionForm extends StatefulWidget {
  // Callback para notificar a tela principal sobre a nova transação
  final Function(String type, double amount) onAddTransaction;

  const NewTransactionForm({
    super.key,
    required this.onAddTransaction,
  });

  @override
  State<NewTransactionForm> createState() =>
      _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  String? _selectedTransactionType;
  String? _errorMessage;

  final List<DropdownMenuItem<String>> _transactionOptions = [
    const DropdownMenuItem(
      value: 'Depósito',
      child: Text('Depósito'),
    ),
    const DropdownMenuItem(
      value: 'Transferência',
      child: Text('Transferência'),
    ),
  ];

  void _handleSubmit() {
    setState(() {
      _errorMessage = null;
    });

    if (_selectedTransactionType == null) {
      setState(() {
        _errorMessage = 'Por favor, selecione o tipo da transação.';
      });
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final valueText = _valueController.text.replaceAll(',', '.');
      final amount = double.tryParse(valueText);

      if (amount == null || amount <= 0) {
        setState(() {
          _errorMessage = 'Por favor, insira um valor válido.';
        });
        return;
      }

      // Converte para negativo se for transferência
      final finalAmount = _selectedTransactionType == 'Transferência'
          ? -amount
          : amount;

      widget.onAddTransaction(_selectedTransactionType!, finalAmount);

      // Limpa o formulário
      _formKey.currentState?.reset();
      _valueController.clear();
      setState(() {
        _selectedTransactionType = null;
      });
      // Remove o foco para fechar o teclado
      FocusScope.of(context).unfocus();
    }
  }

  final List<String> _imagesUrls = [];
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _listImages();

    super.initState();
  }

  void _listImages() async {
    setState(() {
      _loading = true;
    });

    final ListResult result = await FirebaseStorage.instance
        .ref('uploads')
        .list();

    final List<String> urls = await Future.wait(
      result.items.map((element) async {
        return await element.getDownloadURL();
      }),
    );

    setState(() {
      _loading = false;
      _imagesUrls.addAll(urls);
    });
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        var file = File(pickedFile.path);
        _uploadImage(file);
      }
    } catch (e) {
      print(e);
    }
  }

  void _uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;

      var storageRef = FirebaseStorage.instance.ref(
        'uploads/$fileName',
      );
      storageRef.putFile(file);

      var url = await storageRef.getDownloadURL();
      setState(() {
        _loading = false;
        _imagesUrls.add(url);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: const Color(0xFFCBCBCB), // color-bg-gray
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nova transação',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                CustomDropdown(
                  label: 'Tipo de Transação',
                  value: _selectedTransactionType,
                  items: _transactionOptions,
                  hint: 'Selecione...',
                  onChanged: (value) {
                    setState(() {
                      _selectedTransactionType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  label: 'Valor',
                  controller: _valueController,
                  hintText: 'R\$ 0,00',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O valor é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: _handleSubmit,
                    text: 'Concluir transação',
                    variant: ButtonVariant.secondary,
                  ),
                ),
                CustomButton(
                  onPressed: _pickImage,
                  text: 'Adicionar comprovante',
                  variant: ButtonVariant.danger,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
