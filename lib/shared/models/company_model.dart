// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

import 'fleet_model.dart';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  String id;
  String ownerId;
  String name;
  String address;
  String contact;
  String email;
  String imgUrl;
  List<Fleet> fleet;
  List destinations;

  Company({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.imgUrl,
    required this.fleet,
    required this.destinations,
  });

  factory Company.fromJson(Map<String, dynamic>? json) => Company(
      id: json?["id"] ?? "",
      ownerId: json?["ownerId"] ?? "",
      name: json?["name"] ?? "",
      address: json?["address"] ?? "",
      contact: json?["contact"] ?? "",
      email: json?["email"] ?? "",
      imgUrl: json?["imgURL"] ?? "",
      // fleet: [],
      fleet: List<Fleet>.from(
          (json?["fleet"] ?? <Fleet>[]).map((x) => Fleet.fromJson(x))),
      destinations: json?["destinations"] ?? <String>[]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "name": name,
        "address": address,
        "contact": contact,
        "email": email,
        "imgURL": imgUrl,
        "destinations": destinations,
        "fleet": fleet,
      };
}
