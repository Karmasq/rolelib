import 'package:flutter/material.dart';
import 'package:roledrilling_app/helpers/pdf_helper.dart';
import 'package:roledrilling_app/models/reporte_model.dart';

class ReportScreen extends StatefulWidget {
  final Reporte reporte;
  final String proyecto; // Agregamos el campo "proyecto" aquí

  const ReportScreen({
    Key? key,
    required this.reporte,
    required this.proyecto, // Agregamos el campo "proyecto" aquí
  }) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Generado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _generatePDF(widget.reporte);
              },
              child: const Text('Guardar Reporte en PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePDF(Reporte reporte) async {
    await PdfHelper.showPDF([reporte]); // Pasamos el reporte en una lista
  }
}
