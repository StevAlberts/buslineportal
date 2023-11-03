// To parse this JSON data, do
//
//     final passenger = passengerFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PassengerTicket passengerTicketFromJson(String str) =>
    PassengerTicket.fromJson(json.decode(str));

String passengerTicketToJson(PassengerTicket data) =>
    json.encode(data.toJson());

class PassengerTicket {
  String id;
  String tripId;
  String names;
  String? contact;
  String toDest;
  String fromDest;
  String seatNo;
  int fare;
  DateTime travelDate;
  bool isValid;
  bool isBoarded;
  List entryPoint;
  List exitPoint;
  bool isExit;
  bool isMale;

  Timestamp? timestamp;

  PassengerTicket({
    required this.id,
    required this.tripId,
    required this.names,
    required this.isMale,
    required this.toDest,
    required this.fromDest,
    required this.seatNo,
    required this.fare,
    required this.travelDate,
    required this.isValid,
    required this.isBoarded,
    required this.entryPoint,
    required this.exitPoint,
    required this.isExit,
    this.timestamp,
    this.contact,
  });

  factory PassengerTicket.fromJson(Map<String, dynamic> json) {
    return PassengerTicket(
      id: json["id"],
      tripId: json["tripId"],
      names: json["names"],
      isMale: json["isMale"]??true,
      contact: json["contact"],
      toDest: json["toDest"],
      fromDest: json["fromDest"],
      fare: json["fare"],
      seatNo: json["seatNo"],
      entryPoint: json["entryPoint"] ?? [],
      exitPoint: json["exitPoint"] ?? [],
      travelDate: json["travelDate"].toDate(),
      isBoarded: json["isBoarded"] ?? false,
      isExit: json["isExit"] ?? false,
      isValid: json["isValid"] ?? false,
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "tripId": tripId,
    "names": names,
    "contact": contact,
    "toDest": toDest,
    "fromDest": fromDest,
    "fare": fare,
    "seatNo": seatNo,
    "exitPoint": exitPoint,
    "entryPoint": entryPoint,
    "travelDate": travelDate,
    "isExit": isExit,
    "isBoarded": isBoarded,
    "isValid": isValid,
    "isMale": isMale,
    "timestamp": DateTime.now(),
  };
}
