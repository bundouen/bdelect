// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) =>
    List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
  Group({
    required this.id,
    required this.group,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.creatorId,
  });

  int id;
  String group;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int creatorId;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        group: json["group"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        creatorId: json["creatorId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group": group,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "creatorId": creatorId,
      };
}
