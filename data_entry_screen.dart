import 'package:flutter/material.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/screens/data_entry_perforado.dart'; // Importa la pantalla DataEntryPerforado

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  String _proyecto = '';
  String _fecha = '';
  String _maquina = '';
  String _turno = '';
  String _pozo = '';
  String _perforista = '';
  String _ayudante1 = '';
  String _ayudante2 = '';
  String _supervisor = '';
  String _supervisorSeguridad = '';

  Future<void> _guardarReporte() async {
    Reporte reporte = Reporte(
      proyecto: _proyecto,
      fecha: _fecha,
      maquina: _maquina,
      turno: _turno,
      pozo: _pozo,
      perforista: _perforista,
      ayudante1: _ayudante1,
      ayudante2: _ayudante2,
      supervisor: _supervisor,
      supervisorSeguridad: _supervisorSeguridad,
    );

    // Guardar el reporte en la base de datos
    await DatabaseHelper.instance.insertReporte(reporte);

    // Mostrar mensaje de éxito
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Éxito'),
        content: Text('Se han guardado los datos correctamente.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo de éxito
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataEntryPerforacion(reporte: reporte), // Pasa el reporte como argumento
                ),
              );
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
        title: Text('Ingreso de Datos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Proyecto'),
              onChanged: (value) {
                setState(() {
                  _proyecto = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Fecha'),
              onChanged: (value) {
                setState(() {
                  _fecha = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Máquina'),
              onChanged: (value) {
                setState(() {
                  _maquina = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Turno'),
              onChanged: (value) {
                setState(() {
                  _turno = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Pozo'),
              onChanged: (value) {
                setState(() {
                  _pozo = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Perforista'),
              onChanged: (value) {
                setState(() {
                  _perforista = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ayudante 1'),
              onChanged: (value) {
                setState(() {
                  _ayudante1 = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ayudante 2'),
              onChanged: (value) {
                setState(() {
                  _ayudante2 = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Supervisor'),
              onChanged: (value) {
                setState(() {
                  _supervisor = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Supervisor de Seguridad'),
              onChanged: (value) {
                setState(() {
                  _supervisorSeguridad = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarReporte,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
