import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String id;
  String companyId;
  String firstName;
  String lastName;
  String gender;
  DateTime? dob;
  String? nin;
  String phone;
  String role;
  bool isOnline;
  List jobs;

  Timestamp? timestamp;

  Employee({
    required this.id,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.dob,
    this.nin,
    required this.phone,
    required this.role,
    required this.isOnline,
    required this.jobs,
    this.timestamp,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    companyId: json["companyId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    dob: null,
    nin: null,
    role: json["role"],
    phone: json["phone"]??"",
    isOnline: json["isOnline"]??false,
    jobs: json["jobs"]??[],
    timestamp:  json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "dob": null,
    "nin": null,
    "role": role,
    "phone":phone,
    "isOnline": isOnline,
    "jobs": jobs,
    "timestamp":Timestamp.now(),
  };
}