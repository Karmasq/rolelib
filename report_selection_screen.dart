import 'package:flutter/material.dart';
import 'package:roledrilling_app/models/reporte_model.dart';

class ReportSelectionScreen extends StatefulWidget {
  final List<Reporte> reportes;
  final List<Reporte> selectedReports;
  final Function(List<Reporte> selectedReports) onSendReports;

  const ReportSelectionScreen({
    required this.reportes,
    required this.selectedReports,
    required this.onSendReports,
  });

  @override
  _ReportSelectionScreenState createState() => _ReportSelectionScreenState();
}

class _ReportSelectionScreenState extends State<ReportSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Informes'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSendReports(widget.selectedReports);
              Navigator.pop(context);
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.reportes.length,
        itemBuilder: (context, index) {
          final reporte = widget.reportes[index];
          final isSelected = widget.selectedReports.contains(reporte);

          return ListTile(
            leading: IconButton(
              icon: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    widget.selectedReports.remove(reporte);
                  } else {
                    widget.selectedReports.add(reporte);
                  }
                });
              },
            ),
            title: Text('Reporte #${reporte.id}'),
            subtitle: Text('Fecha: ${reporte.fecha}'),
            onTap: () {
              setState(() {
                if (isSelected) {
                  widget.selectedReports.remove(reporte);
                } else {
                  widget.selectedReports.add(reporte);
                }
              });
            },
          );
        },
      ),
    );
  }
}
