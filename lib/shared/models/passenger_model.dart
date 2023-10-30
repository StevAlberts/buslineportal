// To parse this JSON data, do
//
//     final passenger = passengerFromJson(jsonString);

import 'dart:convert';

Passenger passengerFromJson(String str) => Passenger.fromJson(json.decode(str));

String passengerToJson(Passenger data) => json.encode(data.toJson());

class Passenger {
  String id;
  String names;
  String contact;
  String toDest;
  String fromDest;
  String seatNo;
  int fare;
  DateTime travelDate;

  Passenger({
    required this.id,
    required this.names,
    required this.contact,
    required this.toDest,
    required this.fromDest,
    required this.seatNo,
    required this.fare,
    required this.travelDate,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["id"],
    names: json["names"],
    contact: json["contact"],
    toDest: json["toDest"],
    fromDest: json["fromDest"],
    fare: json["fare"],
    seatNo: json["ticketNo"],
    travelDate: json["travelDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "names": names,
    "contact": contact,
    "toDest": toDest,
    "fromDest": fromDest,
    "fare": fare,
    "ticketNo":seatNo,
    "travelDate": travelDate,
  };
}
