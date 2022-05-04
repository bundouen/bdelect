

import 'dart:convert';

UserToken userTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String userTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
    UserToken({
       required this.user,
       required this.token,
    });

    final User user;
    final String token;

    factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
      required  this.id,
      required  this.name,
      required  this.phone,
      required  this.password,
      required  this.currentAddr,
      required  this.createdAt,
      required  this.updatedAt,
    });

    final int id;
    final String name;
    final String phone;
    final String password;
    final String currentAddr;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        currentAddr: json["currentAddr"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "password": password,
        "currentAddr": currentAddr,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
