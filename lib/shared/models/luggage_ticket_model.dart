// To parse this JSON data, do
//
//     final passenger = passengerFromJson(jsonString);

import 'dart:convert';

LuggageTicket luggageFromJson(String str) =>
    LuggageTicket.fromJson(json.decode(str));

String luggageToJson(LuggageTicket data) => json.encode(data.toJson());

class LuggageTicket {
  String id;
  String tripId;
  String senderNames;
  String senderContact;
  String toDest;
  String receiverNames;
  String receiverContact;
  String description;
  int fare;
  bool isDispatch;
  bool isValid;
  bool isDelivered;
  List imgUrls;
  List? entryPoint;
  List? exitPoint;
  DateTime timestamp;

  LuggageTicket({
    required this.id,
    required this.tripId,
    required this.senderNames,
    required this.senderContact,
    required this.toDest,
    required this.receiverContact,
    required this.receiverNames,
    required this.description,
    required this.isValid,
    required this.isDelivered,
    required this.isDispatch,
    required this.fare,
    required this.imgUrls,
    this.entryPoint,
    this.exitPoint,
    required this.timestamp,
  });

  factory LuggageTicket.fromJson(Map<String, dynamic> json) => LuggageTicket(
    id: json["id"],
    tripId: json["tripId"],
    senderContact: json["senderContact"],
    senderNames: json["senderNames"],
    toDest: json["toDest"],
    receiverNames: json["receiverNames"],
    receiverContact: json["receiverContact"],
    description: json["description"],
    isDispatch: json["isDispatch"],
    isDelivered: json["isDelivered"],
    isValid: json["isValid"] ?? false,
    fare: json["fare"],
    imgUrls: json["imgUrls"],
    entryPoint: json["entryPoint"],
    exitPoint: json["exitPoint"],
    timestamp: json["timestamp"].toDate(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tripId": tripId,
    "senderContact": senderContact,
    "senderNames": senderNames,
    "toDest": toDest,
    "receiverNames": receiverNames,
    "receiverContact": receiverContact,
    "description": description,
    "isDispatch": isDispatch,
    "isDelivered": isDelivered,
    "isValid": isValid,
    "fare": fare,
    "imgUrls": imgUrls,
    "entryPoint": entryPoint,
    "exitPoint": exitPoint,
    "timestamp": timestamp,
  };
}
