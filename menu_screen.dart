import 'package:flutter/material.dart';
import 'package:roledrilling_app/screens/data_entry_screen.dart';
import 'package:roledrilling_app/screens/report_list_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo centrado y más grande
            Image.asset(
              'lib/assets/images/rolelogo.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            // Botón "Generar reporte" con tamaño fijo
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataEntryScreen()),
                  );
                },
                child: const Text('Generar Reporte'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Cambiar el color de fondo a naranja
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón "Ver reportes" con tamaño fijo
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportListScreen()),
                  );
                },
                child: const Text('Ver Reportes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Cambiar el color de fondo a naranja
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón "Salir" con tamaño fijo
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Cerrar la aplicación al hacer clic en el botón "Salir"
                  Navigator.of(context).pop();
                },
                child: const Text('Salir'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Cambiar el color de fondo a rojo
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}