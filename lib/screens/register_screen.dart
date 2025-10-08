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
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  String _erroMessage = '';
  bool _termsAccepted = false;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Se você tiver uma ilustração, pode adicioná-la aqui.
            // Ex: Image.asset('assets/images/register_image.png', height: 180),
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
            const CustomInput(
              label: 'Nome',
              hintText: 'Digite seu nome completo',
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
              onPressed: () {
                _register();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.dashboard,
                  (route) => false,
                );
              },
              text: 'Criar conta',
              variant: ButtonVariant.primary,
              color: const Color(0xFFD95236),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text
            .trim(),
        password: _passwordController.text.trim(),
      );
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
        _erroMessage = e.toString();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_erroMessage)));
    }
  }

  // libera os controladores quando o widget for descartado
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
