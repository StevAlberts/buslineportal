import 'package:buslineportal/shared/providers/passengers/passengers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/luggage_ticket_model.dart';
import '../../models/passenger_ticket_model.dart';

part 'tickets_provider.g.dart';

@riverpod
Stream<List<PassengerTicket>> streamPassengerTickets(
    StreamPassengerTicketsRef ref,
    String tripId,
    ) {
  final collection = FirebaseFirestore.instance.collection('passengerTickets');

  var ticketStream = collection
      .where('tripId', isEqualTo: tripId).orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => PassengerTicket.fromJson(doc.data()))
      .toList());

  return ticketStream;
}

@riverpod
Stream<List<LuggageTicket>> streamLuggageTickets(
    StreamLuggageTicketsRef ref,
    String tripId,
    ) {
  final collection = FirebaseFirestore.instance.collection('luggageTickets');

  var ticketStream = collection
      .where('tripId', isEqualTo: tripId).orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => LuggageTicket.fromJson(doc.data()))
      .toList());

  return ticketStream;
}
