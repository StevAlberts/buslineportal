import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final _firebaseAuth  = FirebaseAuth.instance;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference requestsCollection =
  FirebaseFirestore.instance.collection('requests');
  final CollectionReference tripsCollection =
  FirebaseFirestore.instance.collection('trips');
  final CollectionReference passengerTicketsCollection =
  FirebaseFirestore.instance.collection('passengerTickets');
  final CollectionReference luggageTicketsCollection =
  FirebaseFirestore.instance.collection('luggageTickets');

  // register new user

// Query job assigned by manager for trip

  // Query bus information (no, company, contacts, busno, start, destination, date

  // Create passenger

  // Save passenger details

  // Query passengers

  // Query passenger details

  //...
}