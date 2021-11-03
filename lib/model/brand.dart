// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

List<Brand> brandFromJson(String str) => List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brand {
    Brand({
       required this.id,
       required this.title,
       required this.imageUrl,
       required this.createdAt,
       required this.updatedAt,
       required this.creatorId,
       required this.creator,
    });

    final int id;
    final String title;
    final String imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int creatorId;
    final Creator creator;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        creatorId: json["creatorId"],
        creator: Creator.fromJson(json["creator"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "creatorId": creatorId,
        "creator": creator.toJson(),
    };
}

class Creator {
    Creator({
      required this.id,
       required this.name,
       required this.email,
       required this.passwordhash,
       required this.compayName,
       required this.phone,
       required this.address,
       required this.image,
       required this.isAdmin,
       required this.isStatus,
       required this.createdAt,
       required this.updatedAt,
    });

    final int id;
    final String name;
    final String email;
    final String passwordhash;
    final String compayName;
    final String phone;
    final String address;
    final String image;
    final bool isAdmin;
    final bool isStatus;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        passwordhash: json["passwordhash"],
        compayName: json["compayName"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        isAdmin: json["isAdmin"],
        isStatus: json["isStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "passwordhash": passwordhash,
        "compayName": compayName,
        "phone": phone,
        "address": address,
        "image": image,
        "isAdmin": isAdmin,
        "isStatus": isStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
