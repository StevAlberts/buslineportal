// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
  String id;
  String companyId;
  CompanyDetails companyDetails;
  String busNo;
  int busSeats;
  List<StaffDetail> staffDetails;
  String fromDest;
  String toDest;
  DateTime travelDate;

  Trip({
    required this.id,
    required this.companyId,
    required this.companyDetails,
    required this.busNo,
    required this.busSeats,
    required this.staffDetails,
    required this.fromDest,
    required this.toDest,
    required this.travelDate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"],
    companyId: json["companyId"],
    companyDetails: CompanyDetails.fromJson(json["companyDetails"]),
    busNo: json["busNo"],
    busSeats: json["busSeats"],
    staffDetails: List<StaffDetail>.from(json["staffDetails"].map((x) => StaffDetail.fromJson(x))),
    fromDest: json["fromDest"],
    toDest: json["toDest"],
    travelDate: json["travelDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "companyDetails": companyDetails.toJson(),
    "busNo": busNo,
    "busSeats":busSeats,
    "staffDetails": List<dynamic>.from(staffDetails.map((x) => x.toJson())),
    "fromDest": fromDest,
    "toDest": toDest,
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

class StaffDetail {
  String name;
  String id;
  String role;
  String photoURL;

  StaffDetail({
    required this.name,
    required this.id,
    required this.role,
    required this.photoURL,
  });

  factory StaffDetail.fromJson(Map<String, dynamic> json) => StaffDetail(
    name: json["name"],
    id: json["id"],
    role: json["role"],
    photoURL: json["photoURL"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "role": role,
    "photoURL": photoURL,
  };
}
