import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Usually, stream-based redirects is more than enough.
// Most of the auth-related logic is handled by the SDK
final firebaseUserProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final authProvider = ChangeNotifierProvider<Auth>((ref) {
  final auth = Auth();
  auth.init();
  return auth;
});


class Auth extends ChangeNotifier {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  bool get isAuthenticated => _user != null;

  // listen to user changes
  Future<void> init() async {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // login user
  Future<Map<User?, String>> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = credentials.user;
      return {_user: ""};
    } on FirebaseAuthException catch (e) {
      return {_user: "${e.message}"};
    }
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = credentials.user;
      return {
        "user": _user,
        "error": null,
      };
    } on FirebaseAuthException catch (e) {
      return {
        "user": null,
        "error": e.message,
      };
    }
  }

  Future<Map<String, dynamic>> verifyPhone(String phone) async {
    try {
      final credentials = await _firebaseAuth.verifyPhoneNumber(
          verificationCompleted: (credentials) {},
          verificationFailed: (failed) {},
          codeSent: (code, number) {},
          codeAutoRetrievalTimeout: (timeout) {});

      return {
        "user": _user,
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
    _user = null;
    notifyListeners();
    return true;
  }
}
