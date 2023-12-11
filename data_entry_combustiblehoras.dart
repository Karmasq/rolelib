import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/combustiblehoras_model.dart';
import 'package:roledrilling_app/screens/data_entry_pruebas_reflex_screen.dart';
import 'package:roledrilling_app/models/reporte_model.dart';

class DataEntryCombustibleHorasScreen extends StatefulWidget {
  final Reporte reporte; 
  const DataEntryCombustibleHorasScreen({Key? key, required this.reporte}) : super(key: key);

  @override
  _DataEntryCombustibleHorasScreenState createState() => _DataEntryCombustibleHorasScreenState();
}

class _DataEntryCombustibleHorasScreenState extends State<DataEntryCombustibleHorasScreen> {
  final TextEditingController _tipoEquipoController = TextEditingController();
  final TextEditingController _cantidadCombustibleController = TextEditingController();
  final TextEditingController _tipoMaquinariaController = TextEditingController();
  final TextEditingController _cantidadHorasController = TextEditingController();

  List<Combustible> combustibleList = [];
  List<Horas> horasList = [];

  void _saveCombustible() async {
    final tipoEquipo = _tipoEquipoController.text;
    final cantidadCombustible = double.tryParse(_cantidadCombustibleController.text) ?? 0.0;

    if (tipoEquipo.isNotEmpty && cantidadCombustible > 0) {
      final combustible = Combustible(
        tipoEquipo: tipoEquipo, 
        cantidad: cantidadCombustible,
        reporteId: widget.reporte.id, // Incluye el ID del reporte
      );
      await DatabaseHelper.instance.insertCombustible(combustible);
      _tipoEquipoController.clear();
      _cantidadCombustibleController.clear();
      _updateLists();
      _showSuccessAlert("¡Combustible guardado exitosamente!");
    }
  }

  void _saveHoras() async {
    final tipoMaquinaria = _tipoMaquinariaController.text;
    final cantidadHoras = int.tryParse(_cantidadHorasController.text) ?? 0;

    if (tipoMaquinaria.isNotEmpty && cantidadHoras > 0) {
      final horas = Horas(
        tipoMaquinaria: tipoMaquinaria, 
        cantidad: cantidadHoras,
        reporteId: widget.reporte.id, // Incluye el ID del reporte
      );
      await DatabaseHelper.instance.insertHoras(horas);
      _tipoMaquinariaController.clear();
      _cantidadHorasController.clear();
      _updateLists();
      _showSuccessAlert("¡Horas guardadas exitosamente!");
    }
  }

 Future<void> _updateLists() async {
    // Corrección: Añadir el reporteId al llamar a getCombustibles y getHoras
    final combustibles = await DatabaseHelper.instance.getCombustibles(widget.reporte.id!);
    final horas = await DatabaseHelper.instance.getHoras(widget.reporte.id!);
    setState(() {
      combustibleList = combustibles;
      horasList = horas;
    });
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
  void initState() {
    super.initState();
    _updateLists();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Equipo y maquinaria'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tipoEquipoController,
                decoration: InputDecoration(labelText: 'Equipo'),
              ),
              TextFormField(
                controller: _cantidadCombustibleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad de Combustible (litros)'),
              ),
              ElevatedButton(
                onPressed: _saveCombustible,
                child: Text('Guardar Combustible'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _tipoMaquinariaController,
                decoration: InputDecoration(labelText: 'Maquinaria'),
              ),
              TextFormField(
                controller: _cantidadHorasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad de Horas'),
              ),
              ElevatedButton(
                onPressed: _saveHoras,
                child: Text('Guardar Horas'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataEntryPruebasReflexScreen(reporte: widget.reporte),
                    ),
                  );
                },
                child: Text('Siguiente'),
              ),

              // ... (rest of the code remains the same)
            ],
          ),
        ),
      ),
    );
  }
}