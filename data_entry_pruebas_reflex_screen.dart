import 'package:flutter/material.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/pruebasreflex_model.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/screens/report_list_screen.dart';

class DataEntryPruebasReflexScreen extends StatefulWidget {
  final Reporte reporte;
  const DataEntryPruebasReflexScreen({Key? key, required this.reporte}) : super(key: key);

  @override
  _DataEntryPruebasReflexScreenState createState() => _DataEntryPruebasReflexScreenState();
}

class _DataEntryPruebasReflexScreenState extends State<DataEntryPruebasReflexScreen> {
  final TextEditingController _profundidadController = TextEditingController();
  final TextEditingController _magFieldController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _magDipController = TextEditingController();
  final TextEditingController _inclinacionController = TextEditingController();
  final TextEditingController _azimutController = TextEditingController();

  List<PruebasReflex> pruebasReflexList = [];

 void _savePruebasReflex() async {
    final profundidad = double.tryParse(_profundidadController.text) ?? 0.0;
    final magField = double.tryParse(_magFieldController.text) ?? 0.0;
    final temp = double.tryParse(_tempController.text) ?? 0.0;
    final magDip = double.tryParse(_magDipController.text) ?? 0.0;
    final inclinacion = double.tryParse(_inclinacionController.text) ?? 0.0;
    final azimut = double.tryParse(_azimutController.text) ?? 0.0;

    if (profundidad > 0) {
      final pruebasReflex = PruebasReflex(
        profundidad: profundidad,
        magField: magField,
        temp: temp,
        magDip: magDip,
        inclinacion: inclinacion,
        azimut: azimut,
        reporteId: widget.reporte.id, // Incluye el ID del reporte
      );

      await DatabaseHelper.instance.insertPruebasReflex(pruebasReflex);
      _clearInputFields();
      _updateLists();
      _showSuccessAlert("¡Datos de Pruebas Reflex guardados exitosamente!");
    }
  }


  Future<void> _updateLists() async {
    // Corrección: Añadir el reporteId al llamar a getPruebasReflex
    final pruebasReflex = await DatabaseHelper.instance.getPruebasReflex(widget.reporte.id!);
    setState(() {
      pruebasReflexList = pruebasReflex;
    });
  }

  void _clearInputFields() {
    _profundidadController.clear();
    _magFieldController.clear();
    _tempController.clear();
    _magDipController.clear();
    _inclinacionController.clear();
    _azimutController.clear();
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Éxito"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Datos de Pruebas Reflex'),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ...

TextField(
  controller: _profundidadController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Profundidad'),
),
TextField(
  controller: _magFieldController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'MAG.FIELD'),
),
TextField(
  controller: _tempController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'TEMP'),
),
TextField(
  controller: _magDipController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'MAG.DIP'),
),
TextField(
  controller: _inclinacionController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'INCLINACIÓN'),
),
TextField(
  controller: _azimutController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'AZIMUT'),
),
            ElevatedButton(
              onPressed: _savePruebasReflex,
              child: Text('Guardar Datos'),
            ),
             // Botón para generar reporte y redirigir a ReportListScreen
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportListScreen(),
                    ),
                  );
                },
                child: Text('Generar Reporte'),
              ),
            SizedBox(height: 16),
            Text('Registros de Pruebas Reflex:', style: TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pruebasReflexList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Profundidad: ${pruebasReflexList[index].profundidad}'),
                  // Muestra otros datos aquí...
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}


}


