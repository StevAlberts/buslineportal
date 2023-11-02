import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');

  // register new user

  Future<bool> addNewUser(User user,String firstName, String lastName) async {
    try {
      // Set user data
      var data = {
        "uid": user.uid,
        "email": user.email,
        "firstName": firstName,
        "lastName": lastName,
        "emailVerified": user.emailVerified,
        "phoneNumber": user.phoneNumber,
        "photoURL": user.photoURL,
        "timestamp":DateTime.now(),
      };

      await requestsCollection.doc(user.uid).set(data);
      debugPrint('User registered.');
      return true;
    } catch (e) {
      debugPrint('addNewUser Error: $e');
      return false;
    }
  }
}

AuthenticationService authenticationService = AuthenticationService();
