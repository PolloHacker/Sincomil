import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({super.key, required this.title, required this.tipo, required this.aluno});
  final String aluno;
  final String title;
  final String tipo;

  Future<Uint8List> getPdf() async {
    final pdf = pw.Document(title: title);
    //TODO:get image from source
    final netImage = await networkImage('https://sincomil.eb.mil.br/images/logo-gray.png');
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(netImage),
      ); // Center
    }));
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (format) => getPdf(),
        pdfFileName: "mens $aluno $tipo $title",
        canDebug: false,
      ),
    );
  }
}
