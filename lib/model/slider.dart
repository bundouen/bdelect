// To parse this JSON data, do
//
//     final slider = sliderFromJson(jsonString);

import 'dart:convert';

List<Slider> sliderFromJson(String str) =>
    List<Slider>.from(json.decode(str).map((x) => Slider.fromJson(x)));

String sliderToJson(List<Slider> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Slider {
  Slider({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.creatorId,
  });

  int id;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int creatorId;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        creatorId: json["creatorId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "creatorId": creatorId,
      };
}
