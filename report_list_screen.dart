import 'package:flutter/material.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/helpers/pdf_helper.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  _ReportListScreenState createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  List<Reporte> _reportes = [];
  List<Reporte> _selectedReportes = [];
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    _loadReportes();
  }

  Future<void> _viewReport(Reporte reporte) async {
    await PdfHelper.showPDF([reporte]);
  }

  Future<void> _loadReportes() async {
    final reportes = await DatabaseHelper.instance.getReportes();
    setState(() {
      _reportes = reportes;
    });
  }

  Future<void> _deleteSelectedReports() async {
    for (var reporte in _selectedReportes) {
      await DatabaseHelper.instance.deleteReporte(reporte.id!);
    }
    await _loadReportes();
    setState(() {
      _selectedReportes.clear();
      _isSelecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes Generados'),
        actions: [
          if (_isSelecting)
            IconButton(
              onPressed: () {
                setState(() {
                  _isSelecting = false;
                  _selectedReportes.clear();
                });
              },
              icon: Icon(Icons.cancel),
            ),
          if (!_isSelecting)
            IconButton(
              onPressed: () {
                setState(() {
                  _isSelecting = true;
                });
              },
              icon: Icon(Icons.select_all),
            ),
        ],
      ),
      body: _reportes.isEmpty
          ? Center(child: Text('No hay reportes generados'))
          : ListView.builder(
              itemCount: _reportes.length,
              itemBuilder: (context, index) {
                final reporte = _reportes[index];
                final isSelected = _selectedReportes.contains(reporte);

                return ListTile(
                  leading: _isSelecting
                      ? Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                _selectedReportes.add(reporte);
                              } else {
                                _selectedReportes.remove(reporte);
                              }
                            });
                          },
                        )
                      : null,
                  title: Text('Reporte de perforación'),
                  subtitle: Text('Fecha: ${reporte.fecha}'),
                  onTap: () {
                    if (_isSelecting) {
                      setState(() {
                        if (isSelected) {
                          _selectedReportes.remove(reporte);
                        } else {
                          _selectedReportes.add(reporte);
                        }
                      });
                    } else {
                      _viewReport(reporte);
                    }
                  },
                );
              },
            ),
      floatingActionButton: _isSelecting
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Eliminar Reportes'),
                    content: Text('¿Quieres borrar los reportes seleccionados?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          _deleteSelectedReports();
                          Navigator.pop(context);
                        },
                        child: Text('Eliminar'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Eliminar',
              child: Icon(Icons.delete),
            )
          : null,
    );
  }
}