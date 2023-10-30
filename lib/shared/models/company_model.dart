// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  String id;
  String name;
  String address;
  String contact;
  String email;
  String imgUrl;

  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.imgUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    contact: json["contact"],
    email: json["email"],
    imgUrl: json["imgURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "contact": contact,
    "email": email,
    "imgURL": imgUrl,
  };
}
