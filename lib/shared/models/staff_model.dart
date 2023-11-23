import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  String id;
  String companyId;
  String companyName;
  String firstName;
  String lastName;
  String gender;
  DateTime? dob;
  String? nin;
  String phone;
  String role;
  bool isOnline;
  String? deviceId;
  String? deviceName;
  String? sessionUid;
  String? passcode;
  String? reservePass;
  String? currentTrip;

  String? email;
  List trips;
  Timestamp? timestamp;

  Staff({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.dob,
    this.nin,
    required this.phone,
    required this.role,
    required this.isOnline,
    required this.trips,
    this.deviceId,
    this.deviceName,
    this.sessionUid,
    this.currentTrip,
    this.passcode,
    this.reservePass,
    this.timestamp,
    required this.email,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        id: json["id"],
        companyId: json["companyId"],
        companyName: json["companyName"] ?? "",
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dob: null,
        nin: null,
        role: json["role"],
        phone: json["phone"] ?? "",
        isOnline: json["isOnline"] ?? false,
        deviceId: json["deviceId"],
        deviceName: json["deviceName"],
        currentTrip: json["currentTrip"],
        sessionUid: json["sessionUid"],
        passcode: json["passcode"],
        email: json["email"],
        reservePass: json["reservePass"],
        trips: json["trips"] ?? [],
        timestamp: json["timestamp"],
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
        "phone": phone,
        "isOnline": isOnline,
        "deviceId": deviceId,
        "currentTrip": currentTrip,
        "sessionUid": sessionUid,
        "passcode": passcode,
        "deviceName": deviceName,
        "reservePass": reservePass,
        "email": email,
        "trips": trips,
        "timestamp": Timestamp.now(),
      };
}
