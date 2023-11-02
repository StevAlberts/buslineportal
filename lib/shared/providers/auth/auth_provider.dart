import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../network/services/authentication_service.dart';

final firebaseUserProvider = StreamProvider<User?>(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);


final authProvider = StateNotifierProvider<Auth, User?>(
  (ref) => Auth(),
  name: 'authProvider',
);

class FirebaseErrors {
  static void showError(BuildContext context, FirebaseAuthException error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message!),
      ),
    );
  }
}

class Auth extends StateNotifier<User?> {
  Auth() : super(null);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<User?, String>> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = credentials.user;

      return {state: ""};
    } on FirebaseAuthException catch (e) {
      return {state: "${e.message}"};
    }
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final credentials = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = credentials.user;

      return {
        "user": state,
        "error": null,
      };
    } on FirebaseAuthException catch (e) {
      return {
        "user": null,
        "error": e.message,
      };
    }
  }

  Future<String> handleForgotPassword(String email) async {
    try {
      // Send a password reset email to the user.
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return '';
    } on FirebaseAuthException catch (e) {
      return "${e.message}";
    }
  }

  Future<bool> logout() async {
    await _firebaseAuth.signOut();
    state = null;
    return true;
  }
}
