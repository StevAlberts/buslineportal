import 'package:buslineportal/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register new user

  Future<bool> addUserRequest(
      User user, String firstName, String lastName) async {
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
        "timestamp": DateTime.now(),
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

  /// Triggers the email link invite flow.
  Future<String?> sendInviteWithEmailLink(String id, String email) async {
    // Configure the action code settings.
    ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://buslinego.web.app/invite/$id',
      handleCodeInApp: true,
    );

    /// Store the link
    var emailLink = actionCodeSettings.url;

    print(emailLink);

    // Send the email link to the user.
    await _auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    return emailLink;
  }

  /// Handles the sign-in completion when the user clicks the email link.
  Future<User?> handleSignInLink({
    required String id,
    required String newPassword,
    required String emailAuth,
  }) async {
    try {
      final confirmationResult = await _auth.createUserWithEmailAndPassword(
    email: emailAuth,
    password: newPassword,
    );

          final user = confirmationResult.user;

      print(user?.uid);

      // If the user is new (i.e., no password set yet), prompt for password creation.
      if (user != null) {
        // Show UI for user to create and confirm password.
        await user.sendEmailVerification();
        // reload
        await user.reload();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Handle errors (e.g., invalid link, expired link)
      print(e);
      print('Error completing email link sign-in: ${e.message}');
      return null;
    }
  }
}

AuthenticationService authenticationService = AuthenticationService();
