import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/trip_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trips_provider.g.dart';

var passengerTicketsCollection =
    FirebaseFirestore.instance.collection('passengerTickets');
var tripCollection = FirebaseFirestore.instance.collection('trips');

@riverpod
Stream<List<Trip>> streamAllTrips(
  StreamAllTripsRef ref,
  String companyId,
) {
  var ticketStream = tripCollection
      .where('companyId', isEqualTo: companyId)
      .orderBy("travelDate", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trip.fromJson(doc.data())).toList());
  return ticketStream;
}

@riverpod
Stream<Trip> streamTrip(
  StreamTripRef ref,
  String companyId,
) {
  var ticketStream = tripCollection
      .doc(companyId)
      .snapshots()
      .map((snapshot) => Trip.fromJson(snapshot.data()!));

  return ticketStream;
}

@riverpod
Stream<List<Trip>> streamMovingTrips(
  StreamMovingTripsRef ref,
  String companyId,
) {
  var ticketStream = tripCollection
      .where('companyId', isEqualTo: companyId)
      .where("isStarted", isEqualTo: true)
      .where("isEnded", isEqualTo: false)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Trip.fromJson(doc.data())).toList());

  return ticketStream;
}

// @riverpod
// Stream<List<Trip>> streamCurrentTrip(
//     StreamAllTripsRef ref,
//     String companyId,
//     ) {
//   final collection = FirebaseFirestore.instance.collection('passengerTickets');
//
//   var ticketStream = collection
//       .where('companyId', isEqualTo: companyId)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//       .map((doc) => Trip.fromJson(doc.data()))
//       .toList());
//
//   return ticketStream;
// }
