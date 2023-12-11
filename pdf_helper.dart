import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:roledrilling_app/models/herramienta_model.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/helpers/database_helper.dart';
import 'package:roledrilling_app/helpers/file_save_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/perforacion_model.dart';
import 'package:roledrilling_app/models/combustiblehoras_model.dart';
import 'package:roledrilling_app/models/pruebasreflex_model.dart';
import 'package:roledrilling_app/models/operaciones_model.dart';

class PdfHelper {
  static Future<void> showPDF(List<Reporte> reportes) async {
    final pdf = await generateReportPDF(reportes);
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

static Future<pw.Document> generateReportPDF(List<Reporte> reportes) async {
    final pdf = pw.Document();

    if (reportes.isEmpty) {
      return pdf;
    }

    for (final reporte in reportes) {
      if (reporte.id != null) {
        final perforacionesFromDB = 
            await DatabaseHelper.instance.getPerforaciones(reporte.id!);
        final herramientaFromDB = 
            await DatabaseHelper.instance.getHerramienta(reporte.id!);
        final combustiblesFromDB = 
            await DatabaseHelper.instance.getCombustibles(reporte.id!);
        final horasFromDB = 
            await DatabaseHelper.instance.getHoras(reporte.id!);
        final pruebasReflexFromDB = 
            await DatabaseHelper.instance.getPruebasReflex(reporte.id!);

        final perforaciones = List<Perforacion>.from(perforacionesFromDB);
        final herramienta = List<Herramienta>.from(herramientaFromDB);
        final combustibles = List<Combustible>.from(combustiblesFromDB);
        final horas = List<Horas>.from(horasFromDB);
        final pruebasReflexList = List<PruebasReflex>.from(pruebasReflexFromDB);
        
      pdf.addPage(pw.MultiPage(
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Center(
                child: pw.Text(
                  'REPORTE DE PERFORACIÓN ROLE DRILLING',
                  style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'PROYECTO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                  pw.Text(
                    'MAQUINA:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                  pw.Text(
                    'PERFORISTA:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(reporte.proyecto ?? '', style: pw.TextStyle(fontSize: 7)),
                  pw.Text(reporte.maquina ?? '', style: pw.TextStyle(fontSize: 7)),
                  pw.Text(reporte.perforista ?? '', style: pw.TextStyle(fontSize: 7)),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'FECHA:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                  pw.Text(
                    'TURNO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                  pw.Text(
                    'AYUDANTE:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(reporte.fecha ?? '', style: pw.TextStyle(fontSize: 7)),
                  pw.Text(reporte.turno ?? '', style: pw.TextStyle(fontSize: 7)),
                  pw.Text(reporte.ayudante1 ?? '', style: pw.TextStyle(fontSize: 7)),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'POZO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                  pw.Text(
                    'AYUDANTE:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(reporte.pozo ?? '', style: pw.TextStyle(fontSize: 7)),
                  pw.Text(reporte.ayudante2 ?? '', style: pw.TextStyle(fontSize: 7)),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'SUPERVISOR:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(reporte.supervisor ?? '', style: pw.TextStyle(fontSize: 7)),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'SUPERVISOR DE SEGURIDAD:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(reporte.supervisorSeguridad ?? '', style: pw.TextStyle(fontSize: 7)),
                ],
              ),
              // Nueva sección para las perforaciones
              pw.SizedBox(height: 10),
              pw.Text(
                'Perforaciones',
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),

              // Nueva tabla con formato de oficina para las perforaciones
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>[
                    'Perforación',
                    'Tamaño',
                    'Desde',
                    'Hasta',
                    'Total Perforado'
                  ],
                                    ...perforaciones.map((perforacion) => [
                    perforacion.perforacion ?? '',
                    perforacion.tamano ?? '',
                    perforacion.desde.toString(),
                    perforacion.hasta.toString(),
                    perforacion.totalPerforado.toString(),
                  ]),
                ],
                cellAlignment: pw.Alignment.center,
                cellStyle: pw.TextStyle(fontSize: 8),
                headerDecoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#f2f2f2'),
                ),
                border: pw.TableBorder(
                  horizontalInside: pw.BorderSide.none,
                  verticalInside: pw.BorderSide.none,
                ),
              ),

              // Nueva sección para las herramientas
              pw.SizedBox(height: 10),
              pw.Text(
                'Herramientas Utilizadas',
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),

              // Nueva tabla con formato de oficina para las herramientas
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>[
                    'Herramienta',
                    'Número de Serie',
                    'Serie',
                    'Desde',
                    'Hasta',
                    'Total'
                  ],
                  ...herramienta.map((herramienta) => [
                    herramienta.herramienta ?? '',
                    herramienta.numeroSerie ?? '',
                    herramienta.serie ?? '',
                    herramienta.desde.toString(),
                    herramienta.hasta.toString(),
                    herramienta.total.toString(),
                  ]),
                ],
                cellAlignment: pw.Alignment.center,
                cellStyle: pw.TextStyle(fontSize: 8),
                headerDecoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#f2f2f2'),
                ),
                border: pw.TableBorder(
                  horizontalInside: pw.BorderSide.none,
                  verticalInside: pw.BorderSide.none,
                ),
              ),

              // Resto de tu código para combustibles, horas y pruebas reflex...
            ],
          ),
        ],
      ));
    }
    return pdf;
  }
        return pdf;
    }
    

Future<void> sendPDF(List<Reporte> reportes, String? filePath) async {
    final pdf = await generateReportPDF(reportes);

    final Uint8List pdfBytes = await pdf.save();
    final String pdfFileName = "reportes.pdf";
    final pdfPath = await FileSaveHelper.saveFile(pdfBytes, pdfFileName);
    try {
      await launch(
        'mailto:?subject=Reportes%20de%20Perforación&body=Adjunto%20se%20encuentran%20los%20reportes%20de%20perforación%20en%20formato%20PDF.&attachment=$pdfPath',
      );
    } catch (e) {
      print('No se pudo abrir la aplicación de correo.');
    }
  }
}