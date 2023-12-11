import 'package:flutter/material.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/perforacion_model.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'data_entry_herramienta.dart'; // Importa el archivo de entrada de datos para herramientas

class DataEntryPerforacion extends StatefulWidget {
  final Reporte reporte; // Recibe el reporte como argumento
  const DataEntryPerforacion({Key? key, required this.reporte}) : super(key: key);

  @override
  _DataEntryPerforacionState createState() => _DataEntryPerforacionState();
}

class _DataEntryPerforacionState extends State<DataEntryPerforacion> {
  TextEditingController _perforacionController = TextEditingController();
  TextEditingController _tamanoController = TextEditingController();
  TextEditingController _desdeController = TextEditingController();
  TextEditingController _hastaController = TextEditingController();
  TextEditingController _totalPerforadoController = TextEditingController();

  List<Perforacion> _perforaciones = [];

  Future<void> _guardarPerforacion() async {
    Perforacion perforacion = Perforacion(
      perforacion: _perforacionController.text,
      tamano: _tamanoController.text,
      desde: double.tryParse(_desdeController.text) ?? 0.0,
      hasta: double.tryParse(_hastaController.text) ?? 0.0,
      totalPerforado: double.tryParse(_totalPerforadoController.text) ?? 0.0,
      reporteId: widget.reporte.id, // Asigna el ID del reporte actual
    );

    await DatabaseHelper.instance.insertPerforacion(perforacion);

    _perforacionController.clear();
    _tamanoController.clear();
    _desdeController.clear();
    _hastaController.clear();
    _totalPerforadoController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Éxito'),
        content: Text('Se han guardado los datos correctamente.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo de éxito
              setState(() {
                _perforaciones.add(perforacion);
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
        title: Text('Ingreso de Datos de Perforación'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _perforacionController,
              decoration: InputDecoration(labelText: 'Perforación'),
            ),
            TextFormField(
              controller: _tamanoController,
              decoration: InputDecoration(labelText: 'Tamaño'),
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
              controller: _totalPerforadoController,
              decoration: InputDecoration(labelText: 'Total Perforado'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarPerforacion,
              child: Text('Guardar'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataEntryHerramienta(reporte: widget.reporte), // Pasa el reporte como argumento
                  ),
                );
              },
              child: Text('Siguiente'),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _perforaciones.map((perforacion) {
                String parameterString = widget.reporte.id?.toString() ?? ''; // Convierte a String y maneja nulos
                return Card(
                  child: ListTile(
                    title: Text('ID del Reporte: $parameterString'),
                    subtitle: Text('Tamaño: ${perforacion.tamano}'),
                    trailing: Text('Total Perforado: ${perforacion.totalPerforado}'),
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
    _perforacionController.dispose();
    _tamanoController.dispose();
    _desdeController.dispose();
    _hastaController.dispose();
    _totalPerforadoController.dispose();
    super.dispose();
  }
}
