import 'package:flutter/material.dart';
import 'package:roledrilling_app/models/herramienta_model.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/screens/data_entry_combustiblehoras.dart'; // Importa el archivo de entrada de datos para combustible y horas

class DataEntryHerramienta extends StatefulWidget {
  final Reporte reporte; // Recibe el reporte como argumento
  const DataEntryHerramienta({Key? key, required this.reporte}) : super(key: key);

  @override
  _DataEntryHerramientaState createState() => _DataEntryHerramientaState();
}

class _DataEntryHerramientaState extends State<DataEntryHerramienta> {
  TextEditingController _herramientaController = TextEditingController();
  TextEditingController _numeroSerieController = TextEditingController();
  TextEditingController _serieController = TextEditingController();
  TextEditingController _desdeController = TextEditingController();
  TextEditingController _hastaController = TextEditingController();
  TextEditingController _totalController = TextEditingController();

  List<Herramienta> _herramientas = [];

  Future<void> _guardarHerramienta() async {
    Herramienta herramienta = Herramienta(
      herramienta: _herramientaController.text,
      numeroSerie: _numeroSerieController.text,
      serie: _serieController.text,
      desde: double.tryParse(_desdeController.text) ?? 0.0,
      hasta: double.tryParse(_hastaController.text) ?? 0.0,
      total: double.tryParse(_totalController.text) ?? 0.0,
      reporteId: widget.reporte.id, // Asigna el ID del reporte actual
    );

    await DatabaseHelper.instance.insertHerramienta(herramienta);

    _herramientaController.clear();
    _numeroSerieController.clear();
    _serieController.clear();
    _desdeController.clear();
    _hastaController.clear();
    _totalController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Éxito'),
        content: Text('Se ha guardado la herramienta correctamente.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo de éxito
              setState(() {
                _herramientas.add(herramienta);
              });
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso de Herramienta'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _herramientaController,
              decoration: InputDecoration(labelText: 'Herramienta'),
            ),
            TextFormField(
              controller: _numeroSerieController,
              decoration: InputDecoration(labelText: 'Número de Serie'),
            ),
            TextFormField(
              controller: _serieController,
              decoration: InputDecoration(labelText: 'Serie'),
            ),
            TextFormField(
              controller: _desdeController,
              decoration: InputDecoration(labelText: 'Desde'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _hastaController,
              decoration: InputDecoration(labelText: 'Hasta'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _totalController,
              decoration: InputDecoration(labelText: 'Total'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarHerramienta,
              child: Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataEntryCombustibleHorasScreen(reporte:widget.reporte), // Navega a la pantalla de combustible y horas
                  ),
                );
              },
              child: Text('Siguiente'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _herramientas.map((herramienta) {
                return Card(
                  child: ListTile(
                    title: Text('Herramienta: ${herramienta.herramienta}'),
                    subtitle: Text('Número de Serie: ${herramienta.numeroSerie}'),
                    trailing: Text('Total: ${herramienta.total}'),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _herramientaController.dispose();
    _numeroSerieController.dispose();
    _serieController.dispose();
    _desdeController.dispose();
    _hastaController.dispose();
    _totalController.dispose();
    super.dispose();
  }}