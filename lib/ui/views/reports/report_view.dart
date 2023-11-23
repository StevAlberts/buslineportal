import 'package:buslineportal/network/services/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        maxPageWidth: 700,
        build: (format) => generateInvoice(format),
      ),
    );
  }
}
