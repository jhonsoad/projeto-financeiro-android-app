import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projeto_financeiro/screens/dashboard_screen.dart';
import 'package:projeto_financeiro/screens/home_screen.dart';
import 'package:projeto_financeiro/screens/login_screen.dart';
import 'package:projeto_financeiro/screens/register_screen.dart';
import 'package:projeto_financeiro/theme/app_theme.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // inicializa bindings
  await Firebase.initializeApp();
  await initializeDateFormatting(
    'pt_BR',
    null,
  ); // inicializa dados de formatacao
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.dashboard: (context) => DashboardScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.register: (context) => const RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
