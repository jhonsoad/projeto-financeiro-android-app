import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_financeiro/routes.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  String _erroMessage = '';
  bool _termsAccepted = false;
  bool _isLoading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final bool isFormValid =
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _termsAccepted;
    if (isFormValid != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isFormValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile | Cadastro'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Preencha os campos abaixo para criar sua conta corrente!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                CustomInput(
                  label: 'Nome',
                  hintText: 'Digite seu nome completo',
                  controller: _nameController,
                ),
                const SizedBox(height: 24),
                CustomInput(
                  label: 'Email',
                  hintText: 'Digite seu email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 24),
                CustomInput(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                        _validateForm();
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Li e estou ciente quanto às condições de tratamento dos meus dados conforme descrito na Política de Privacidade do banco.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: _isButtonEnabled ? _register : () {},
                  text: 'Criar conta',
                  variant: ButtonVariant.primary,
                  color: _isButtonEnabled
                      ? const Color(0xFFD95236)
                      : Colors.grey,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'name': _nameController.text.trim()});

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.dashboard,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'weak-password') {
          _erroMessage = 'A senha fornecida é muito fraca.';
        } else if (e.code == 'email-already-in-use') {
          _erroMessage = 'Já existe uma conta com este email.';
        } else {
          _erroMessage = 'Ocorreu um erro. Tente novamente.';
        }
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_erroMessage)));
    } catch (e) {
      setState(() {
        _erroMessage = 'Falha ao salvar dados do usuário.';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_erroMessage)));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
