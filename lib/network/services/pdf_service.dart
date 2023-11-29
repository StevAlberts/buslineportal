import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateInvoice(
  PdfPageFormat pageFormat,
) async {
  final lorem = pw.LoremText();

  final products = <Product>[
    Product('19874', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('98452', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('28375', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('95673', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('23763', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('55209', lorem.sentence(3), 23, "Kampala", "Lira", 20000),
    Product('09853', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('23463', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('56783', lorem.sentence(1), 23, "Kampala", "Lira", 20000),
    Product('78256', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('23745', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('07834', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('23547', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
    Product('98387', lorem.sentence(2), 23, "Kampala", "Lira", 20000),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    paymentInfo:
        '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: .15,
    baseColor: PdfColors.green,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  // double get _total =>
  //     products.map<double>((p) => p.total).reduce((a, b) => a + b);

  // double get _grandTotal => _total * (1 + tax);

  // String? _logo;

  // String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    // _logo = await rootBundle.loadString('assets/busline-logo.png');
    // _bgShape = await rootBundle.loadString('assets/busline-logo.png');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        // header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          // _buildHeader(context),
          _contentHeader(context),
          pw.SizedBox(height: 20),
          pw.Text(
            "PASSENGERS TICKETS",
            style: const pw.TextStyle(fontSize: 18, color: PdfColors.blue),
          ),
          pw.SizedBox(height: 10),
          _contentPassengerTable(context),
          pw.SizedBox(height: 40),
          pw.Text(
            "LUGGAGE TICKETS",
            style: const pw.TextStyle(fontSize: 18, color: PdfColors.orange800),
          ),
          pw.SizedBox(height: 10),
          _contentLuggageTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          // _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Column(children: [
          pw.Container(
            height: 20,
            width: 100,
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.pdf417(),
              data: '123456',
              drawText: true,
            ),
          ),
          pw.Text(
            'POWERED BY BUSLINE',
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      // buildBackground: (context) => pw.FullPage(
      //   ignoreMargins: true,
      //   child: pw.SvgImage(svg: _bgShape!),
      // ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Column(
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          'COMPANY NAME',
                          style: pw.TextStyle(
                            // color: baseColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      pw.Text(
                        'Company Address',
                        style: const pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      pw.Text(
                        'Company Phone number',
                        style: const pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      pw.Text(
                        'UAB 123 C',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 4),
                    child: pw.Text(
                      'Trip Summary:',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.DefaultTextStyle(
                    style: const pw.TextStyle(
                      fontSize: 10,
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('From:'),
                            pw.Text('KAMPALA'),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('To:'),
                            pw.Text('LIRA'),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Fare:'),
                            pw.Text('20000'),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Travel Date:'),
                            pw.Text('Fri 13-11-23 @ 7:00 PM'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 50),
            pw.Expanded(
              flex: 1,
              child: pw.DefaultTextStyle(
                style: const pw.TextStyle(
                  fontSize: 10,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      margin: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Text(
                        'Fare Summary:',
                        style: pw.TextStyle(
                            color: baseColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Passengers:'),
                        pw.Text('UGX 1,200,000'),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Luggage:'),
                        pw.Text('UGX 2,150,000'),
                      ],
                    ),
                    pw.Divider(color: accentColor),
                    pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: baseColor,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total:'),
                          pw.Text('3,350,000'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Staff Signatures',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.ListView.builder(
                itemCount: 5,
                itemBuilder: (_, index) {
                  return pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 8),
                      child: pw.Text(
                        "Staff Names 12345$index (ROLE)",
                      ));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  // fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentPassengerTable(pw.Context context) {
    const tableHeaders = [
      'Ticket #',
      'Passenger Names',
      'Seat #',
      'From',
      'To',
      'Fare'
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.blue,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerLeft,
        5: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentLuggageTable(pw.Context context) {
    const tableHeaders = [
      'Ticket #',
      'Luggage Description',
      'Receiver',
      'Destination',
      'Fare'
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.orange800,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

class Product {
  const Product(
    this.sku,
    this.passengerNames,
    this.seatNo,
    this.toDest,
    this.fromDest,
    this.total,
  );

  final String sku;
  final String passengerNames;
  final int seatNo;
  final String fromDest;
  final String toDest;
  final int total;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return passengerNames;
      case 2:
        return seatNo.toString();
      case 3:
        return fromDest.toString();
      case 4:
        return toDest.toString();
      case 5:
        return total.toString();
    }
    return '';
  }
}
