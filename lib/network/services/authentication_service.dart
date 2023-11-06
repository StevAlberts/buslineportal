import 'package:buslineportal/shared/models/user_model.dart';
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

  Future<bool> addUserRequest(User user,String firstName, String lastName) async {
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
        "isGranted": false,
      };

      await requestsCollection.doc(user.uid).set(data);
      debugPrint('User registered.');
      return true;
    } catch (e) {
      debugPrint('addNewUser Error: $e');
      return false;
    }
  }

  Future<bool> createUserProfile(UserModel user) async {
    try {
      await usersCollection.doc(user.uid).set(user.toJson());
      debugPrint('User created.');
      return true;
    } catch (e) {
      debugPrint('create Error: $e');
      return false;
    }
  }
}

AuthenticationService authenticationService = AuthenticationService();
