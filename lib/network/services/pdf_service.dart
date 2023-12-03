import 'dart:typed_data';

import 'package:buslineportal/shared/models/staff_details_model.dart';
import 'package:buslineportal/shared/utils/date_format_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../shared/models/luggage_ticket_model.dart';
import '../../shared/models/passenger_ticket_model.dart';
import '../../shared/models/trip_model.dart';

Future<Uint8List> generateInvoice({
  required PdfPageFormat pageFormat,
  required List<PassengerTicket> passengers,
  required List<LuggageTicket> luggage,
  required Trip trip,
}) async {
  var passengers0 = passengers
      .map((e) =>
          Passenger(e.id, e.names, e.seatNo, e.fromDest, e.toDest, e.fare))
      .toList();

  var luggage0 = luggage
      .map((e) =>
          Luggage(e.id, e.description, e.receiverNames, e.toDest, e.fare))
      .toList();

  final invoice = Invoice(
    passengers: passengers0,
    luggage: luggage0,
    trip: trip,
    baseColor: PdfColors.green,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.passengers,
    required this.luggage,
    required this.trip,
    required this.baseColor,
    required this.accentColor,
  });

  final List<Passenger> passengers;
  final List<Luggage> luggage;
  final Trip trip;
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
                          trip.companyDetails.name.toUpperCase(),
                          style: pw.TextStyle(
                            // color: baseColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      pw.Text(
                        trip.companyDetails.email,
                        style: const pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      pw.Text(
                        trip.companyDetails.contact,
                        style: const pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      pw.Text(
                        trip.bus.licence.toUpperCase(),
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
                            pw.Text('ID:'),
                            pw.Text(trip.id.toUpperCase()),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('From:'),
                            pw.Text(trip.startDest.toUpperCase()),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('To:'),
                            pw.Text(trip.endDest.toUpperCase()),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Fare:'),
                            pw.Text('${trip.fare}'),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Travel Date:'),
                            pw.Text(travelDateFormat(trip.travelDate)),
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
                        'Fare Breakdown:',
                        style: pw.TextStyle(
                            color: baseColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Passengers (${passengers.length}):'),
                        pw.Text(NumberFormat("#,###")
                            .format(calculatePassengerFare(passengers))),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Luggage (${luggage.length}):'),
                        pw.Text(NumberFormat("#,###")
                            .format(calculateLuggageFare(luggage))),
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
                          pw.Text(
                              'UGX ${NumberFormat("#,###").format(calculateTotalFare(passengers, luggage))}'),
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
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
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
              trip.staffDone!.isNotEmpty
                  ? pw.ListView.builder(
                      itemCount: trip.staffDone!.length,
                      itemBuilder: (_, index) {
                        var staff = trip.staffDone![index];
                        return pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Text(
                            "${staff.firstName} ${staff.lastName} - (${staff.role?.toUpperCase()}) - ${staff.staffId}",
                          ),
                        );
                      },
                    )
                  : pw.Text(
                      'No staff completed their activity.'
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
        passengers.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => passengers[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentLuggageTable(pw.Context context) {
    const tableHeaders = [
      'Ticket #',
      'Description',
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
        4: pw.Alignment.center,
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
        luggage.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => luggage[row].getIndex(col),
        ),
      ),
    );
  }
}

class Passenger {
  const Passenger(
    this.ticketNo,
    this.passengerNames,
    this.seatNo,
    this.fromDest,
    this.toDest,
    this.fare,
  );

  final String ticketNo;
  final String passengerNames;
  final String seatNo;
  final String fromDest;
  final String toDest;
  final int fare;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return ticketNo;
      case 1:
        return passengerNames;
      case 2:
        return seatNo.toString();
      case 3:
        return fromDest.toUpperCase();
      case 4:
        return toDest.toUpperCase();
      case 5:
        return NumberFormat("#,###").format(fare);
    }
    return '';
  }
}

class Luggage {
  const Luggage(
    this.ticketNo,
    this.description,
    this.receiver,
    this.toDest,
    this.fare,
  );

  final String ticketNo;
  final String description;
  final String receiver;
  final String toDest;
  final int fare;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return ticketNo;
      case 1:
        return description;
      case 2:
        return receiver.toUpperCase();
      case 3:
        return toDest.toUpperCase();
      case 4:
        return NumberFormat("#,###").format(fare);
    }
    return '';
  }
}

class Staff {
  const Staff(
    this.id,
    this.names,
    this.role,
  );

  final String id;
  final String names;
  final String role;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return id;
      case 1:
        return names;
      case 2:
        return role.toUpperCase();
    }
    return '';
  }
}

double calculatePassengerFare(List<Passenger> passengers) {
  double totalFare = 0;
  for (final passenger in passengers) {
    totalFare += passenger.fare;
  }
  return totalFare;
}

double calculateLuggageFare(List<Luggage> luggage) {
  double totalFare = 0;
  for (final luggage in luggage) {
    totalFare += luggage.fare;
  }
  return totalFare;
}

double calculateTotalFare(List<Passenger> passengers, List<Luggage> luggage) {
  var pass = calculatePassengerFare(passengers);
  var lugg = calculateLuggageFare(luggage);
  var total = pass + lugg;
  return total;
}
