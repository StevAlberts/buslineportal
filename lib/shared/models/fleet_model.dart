import 'dart:convert';

Fleet fleetFromJson(String str) => Fleet.fromJson(json.decode(str));

String fleetToJson(Fleet data) => json.encode(data.toJson());

class Fleet {
  String id;
  String companyId;
  String licence;
  String make;
  String model;
  int year;
  int capacity;

  Fleet({
    required this.id,
    required this.companyId,
    required this.licence,
    required this.make,
    required this.model,
    required this.year,
    required this.capacity,
  });

  factory Fleet.fromJson(Map<String, dynamic> json) => Fleet(
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
    "companyId":companyId,
    "licence": licence,
    "make": make,
    "model": model,
    "year": year,
    "capacity": capacity,
  };
}
