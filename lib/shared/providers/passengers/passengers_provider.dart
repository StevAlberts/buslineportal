
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/passenger_model.dart';

part 'passengers_provider.g.dart';

//Get trip data
// @riverpod
// Trip getTrip(GetTripRef ref) => Trip.fromJson(mockTrip);

final passengerStateProvider = StateProvider<List<Passenger>>((ref) {
  return [];
});

// Seat Data
@riverpod
class PassengerData extends _$PassengerData {
  @override
  set state(AsyncValue<List<Passenger>> newState) {
    // TODO: implement state
    super.state = newState;
  }

  @override
  Future<List<Passenger>> build() async => [];

  Future<List<Passenger>> addPassenger(Passenger passenger) async {
    final previousState = await future;
    previousState.add(passenger);
    ref.notifyListeners();
    return state.value!;
  }

  Future<List<Passenger>> removePassenger(Passenger passenger) async {
    final previousState = await future;
    previousState.remove(passenger);
    ref.notifyListeners();
    return state.value!;
  }
}

// Selected Seat
@riverpod
class SelectedSeats extends _$SelectedSeats {
  @override
  set state(AsyncValue<List<String>> newState) {
    // TODO: implement state
    super.state = newState;
  }

  @override
  Future<List<String>> build() async => [];

  Future<List<String>> addSeat(String seatNo) async {
    final previousState = await future;
    previousState.add(seatNo);
    ref.notifyListeners();
    return state.value!;
  }

  Future<List<String>> removeSeat(String seatNo) async {
    final previousState = await future;
    previousState.remove(seatNo);
    ref.notifyListeners();
    return state.value!;
  }
}

// @riverpod
// Stream<List<PassengerTicket>> streamPassengerTickets(
//     StreamPassengerTicketsRef ref,
//     String tripId,
//     ) {
//   final collection = FirebaseFirestore.instance.collection('passengerTickets');
//
//   var ticketStream = collection
//       .where('tripId', isEqualTo: tripId).orderBy('seatNo', descending: true)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//       .map((doc) => PassengerTicket.fromJson(doc.data()))
//       .toList());
//
//   return ticketStream;
// }
