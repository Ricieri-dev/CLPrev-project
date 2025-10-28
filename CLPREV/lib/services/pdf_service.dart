import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/checklist_model.dart';

class PDFService {
  Future<File> generatePDF(ChecklistModel checklist) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('CHECK-LIST - AVALIAÇÃO AMBIENTAL')),
              pw.SizedBox(height: 20),
              pw.Text('Empresa: ${checklist.companyName}'),
              pw.Text('Data da Visita: ${checklist.visitDate.toString().substring(0, 10)}'),
              pw.Text('Posto: ${checklist.position}'),
              pw.Text('Avaliador: ${checklist.evaluator}'),
              pw.Text('Acompanhante: ${checklist.companion}'),
              pw.Text('RGF ou Matrícula: ${checklist.rgf}'),
              pw.Divider(),
              pw.Header(level: 1, child: pw.Text('DESCRIÇÃO DO AMBIENTE DE TRABALHO')),
              pw.Text('Local: ${checklist.local}'),
              pw.Text('Estrutura: ${checklist.structure}'),
              pw.Text('Área Aproximada: ${checklist.area} m²'),
              pw.Text('Pé Direito Aproximado: ${checklist.ceilingHeight} m'),
              pw.Text('Piso: ${checklist.floor}'),
              pw.Text('Cobertura: ${checklist.coverage}'),
              pw.Text('Ventilação: ${checklist.ventilation}'),
              pw.Text('Janela: ${checklist.windows}'),
              pw.Text('Iluminação: ${checklist.lighting}'),
              // Continue com os outros campos...
            ],
          );
        },
      ),
    );
    final bytes = await pdf.save();
    final directory = await getTemporaryDirectory();
    final file = File(
      p.join(
        directory.path,
        'checklist_${DateTime.now().millisecondsSinceEpoch}.pdf',
      ),
    );

    await file.writeAsBytes(bytes, flush: true);

    return file;
  }
}
