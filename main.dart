import 'dart:async';
import 'package:flutter/material.dart';
import 'package:roledrilling_app/screens/data_entry_screen.dart';
import 'package:roledrilling_app/screens/menu_screen.dart';
import 'package:roledrilling_app/screens/report_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role Drilling App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/data_entry': (context) => DataEntryScreen(),
        '/menu': (context) => const MenuScreen(),
        '/report_list': (context) => const ReportListScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulamos una carga de 4 segundos antes de navegar a la pantalla principal
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/menu');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          // Aquí puedes mostrar el logo de la empresa
          child: Image.asset('lib/assets/images/rolelogo.png'),
        ),
      ),
    );
  }
}