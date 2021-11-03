// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
       required this.id,
       required this.category,
       required this.imageUrl,
       required this.createdAt,
       required this.updatedAt,
       required this.creatorId,
    });

    final int id;
    final String category;
    final String imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int creatorId;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        creatorId: json["creatorId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "creatorId": creatorId,
    };
}
