import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_financeiro/routes.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile | Login'),
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
            // Ex: Image.asset('assets/images/login_image.png', height: 180),
            const SizedBox(height: 32),
            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
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
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Funcionalidade de "Esqueci a senha" será implementada aqui
                },
                child: const Text(
                  'Esqueci a senha!',
                  style: TextStyle(
                    color: Color(0xFFD95236),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: _login,
              text: 'Criar conta',
              variant: ButtonVariant.primary,
              color: const Color(0xFFD95236),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }
}
