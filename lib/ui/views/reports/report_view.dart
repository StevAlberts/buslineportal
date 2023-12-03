import 'package:buslineportal/network/services/pdf_service.dart';
import 'package:buslineportal/shared/models/passenger_ticket_model.dart';
import 'package:buslineportal/shared/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../shared/models/luggage_ticket_model.dart';

class ReportView extends StatelessWidget {
  const ReportView(
      {Key? key,
      required this.trip,
      required this.passengers,
      required this.luggage})
      : super(key: key);

  final Trip trip;
  final List<PassengerTicket> passengers;
  final List<LuggageTicket> luggage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        allowPrinting: true,
        allowSharing: false,
        maxPageWidth: 700,
        build: (format) => generateInvoice(
          pageFormat: format,
          passengers: passengers,
          luggage: luggage,
          trip: trip,
        ),
      ),
    );
  }
}
