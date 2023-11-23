import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  final String? uid;
  final String? email;
  final bool? emailVerified;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? photoURL;
  final String? role;
  final List companyIds;
  final Timestamp? timestamp;

  UserModel({
    required this.companyIds,
    this.uid,
    this.email,
    this.emailVerified,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.photoURL,
    this.timestamp,
    this.role,
  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      email: data?['email'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      emailVerified: data?['emailVerified'],
      phoneNumber: data?['phoneNumber'],
      photoURL: data?['photoURL'],
      timestamp: data?['timestamp'],
      role: data?['role'],
      companyIds: data?['companyIds'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "emailVerified": emailVerified,
      "phoneNumber": phoneNumber,
      "photoURL": photoURL,
      "companyIds":companyIds,
      "role": role,
      "timestamp": DateTime.now(),
    };
  }
}
