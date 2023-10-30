// To parse this JSON data, do
//
//     final route = routeFromJson(jsonString);

import 'dart:convert';

Route routeFromJson(String str) => Route.fromJson(json.decode(str));

String routeToJson(Route data) => json.encode(data.toJson());

class Route {
  String id;
  String names;

  Route({
    required this.id,
    required this.names,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    names: json["names"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "names": names,
  };
}
