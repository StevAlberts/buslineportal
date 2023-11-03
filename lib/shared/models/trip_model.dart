// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

import 'package:buslineportal/shared/models/staff_model.dart';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip extends StaffDetail {
  String id;
  String companyId;
  CompanyDetails? companyDetails;
  String busNo;
  int busSeats;
  List<StaffDetail> staffDetails;
  String startDest;
  String endDest;
  bool isMoving;
  DateTime travelDate;

  Trip({
    required this.id,
    required this.companyId,
     this.companyDetails,
    required this.busNo,
    required this.busSeats,
    required this.staffDetails,
    required this.startDest,
    required this.endDest,
    required this.isMoving,
    required this.travelDate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        companyId: json["companyId"],
        companyDetails: CompanyDetails.fromJson(json["companyDetails"]),
        busNo: json["busNo"],
        busSeats: json["busSeats"],
        staffDetails: List<StaffDetail>.from(
            json["staffDetails"].map((x) => StaffDetail.fromJson(x))),
        startDest: json["startDest"],
        endDest: json["endDest"],
        isMoving: json["isMoving"],
        travelDate: json["travelDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "companyDetails": companyDetails?.toJson(),
        "busNo": busNo,
        "busSeats": busSeats,
        "staffDetails": List<dynamic>.from(staffDetails.map((x) => x.toJson())),
        "startDest": startDest,
        "endDest": endDest,
        "isMoving": isMoving,
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
