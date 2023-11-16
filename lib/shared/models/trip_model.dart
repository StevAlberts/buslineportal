// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

import 'package:buslineportal/shared/models/passenger_model.dart';
import 'package:buslineportal/shared/models/staff_details_model.dart';

import 'fleet_model.dart';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
  String id;
  String companyId;
  CompanyDetails companyDetails;
  List<StaffDetail> staffDetails;
  List<Passenger> passengers;
  Fleet bus;
  String startDest;
  String endDest;
  bool isStarted;
  bool isEnded;
  int fare;
  DateTime travelDate;
  DateTime? departure;
  DateTime? arrival;

  Trip({
    required this.id,
    required this.companyId,
    required this.companyDetails,
    required this.bus,
    required this.staffDetails,
    required this.startDest,
    required this.endDest,
    required this.isStarted,
    required this.isEnded,
    required this.fare,
    required this.passengers,
    required this.departure,
    required this.arrival,
    required this.travelDate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        companyId: json["companyId"],
        companyDetails: CompanyDetails.fromJson(json["companyDetails"]),
        bus: Fleet.fromJson(json["bus"]),
        staffDetails: json["staff"] != null
            ? List<StaffDetail>.from(
                json["staff"].map((x) => StaffDetail.fromJson(x)))
            : [],
        passengers: json["passengers"] != null
            ? List<Passenger>.from(
                json["passengers"].map((data) => Passenger.fromJson(data)))
            : [],
        fare: json["fare"],
        startDest: json["startDest"],
        endDest: json["endDest"],
        isStarted: json["isStarted"] ?? false,
        isEnded: json["isEnded"] ?? false,
        departure: json["departure"]?.toDate(),
        arrival: json["arrival"]?.toDate(),
        travelDate: json["travelDate"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "companyDetails": companyDetails?.toJson(),
        "bus": bus.toJson(),
        "staff": List<dynamic>.from(staffDetails.map((x) => x.toJson())),
        "passengers":
            List<dynamic>.from(passengers.map((data) => data.toJson())),
        "startDest": startDest,
        "endDest": endDest,
        "isStarted": isStarted,
        "isEnded": isEnded,
        "fare": fare,
        "departure": departure,
        "arrival": arrival,
        "travelDate": travelDate,
      };
}

class CompanyDetails {
  String name;
  String email;
  String contact;
  String imgUrl;

  CompanyDetails({
    required this.name,
    required this.email,
    required this.contact,
    required this.imgUrl,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => CompanyDetails(
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        imgUrl: json["imgURL"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "contact": contact,
        "imgURL": imgUrl,
      };
}

Bus fleetFromJson(String str) => Bus.fromJson(json.decode(str));

String fleetToJson(Bus data) => json.encode(data.toJson());

class Bus {
  String id;
  String companyId;
  String licence;
  String make;
  String model;
  int year;
  int capacity;

  Bus({
    required this.id,
    required this.companyId,
    required this.licence,
    required this.make,
    required this.model,
    required this.year,
    required this.capacity,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        companyId: json["companyId"],
        licence: json["licence"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "licence": licence,
        "make": make,
        "model": model,
        "year": year,
        "capacity": capacity,
      };
}
