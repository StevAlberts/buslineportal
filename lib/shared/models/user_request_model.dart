import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRequestModel {
  final String? uid;
  final String? email;
  final bool? emailVerified;

  final bool? isGranted;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? photoURL;
  final Timestamp? timestamp;

  UserRequestModel({
    this.uid,
    this.email,
    this.emailVerified,
    this.isGranted,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.photoURL,
    this.timestamp,
  });

  factory UserRequestModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserRequestModel(
      uid: data?['uid'],
      email: data?['email'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      emailVerified: data?['emailVerified'],
      isGranted: data?['isGranted'],
      phoneNumber: data?['phoneNumber'],
      photoURL: data?['photoURL'],
      timestamp: data?['timestamp'],
    );
  }

  factory UserRequestModel.fromJson(
      Map? data) {
    return UserRequestModel(
      uid: data?['uid'],
      email: data?['email'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      emailVerified: data?['emailVerified'],
      isGranted: data?['isGranted']?? false,
      phoneNumber: data?['phoneNumber'],
      photoURL: data?['photoURL'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore(User user) {
    return {
      "uid": user.uid,
      "email": user.email,
      "firstName": firstName,
      "lastName": lastName,
      "emailVerified": user.emailVerified,
      "isGranted": false,
      "phoneNumber": user.phoneNumber,
      "photoURL": user.photoURL,
      "timestamp": DateTime.now(),
    };
  }
}
