// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
    Products({
     required  this.totalRecord,
     required  this.data,
    });

    final int totalRecord;
    final List<Datum> data;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        totalRecord: json["totalRecord"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalRecord": totalRecord,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
       required this.id,
       required this.productCode,
       required this.productName,
       required this.qty,
       required this.price,
       required this.discount,
       required this.instock,
       required this.productDetail,
       required this.color,
       required this.isArrival,
       required this.isHotProduct,
       required this.image,
       required this.isFaverite,
       required this.createdAt,
       required this.updatedAt,
       required this.groupId,
       required this.categoryId,
       required this.brandId,
       required this.creatorId,
       required this.category,
       required this.group,
       required this.brand,
       required this.creator,
       required this.imagedetails,
    });

    final int id;
    final String productCode;
    final String productName;
    final int qty;
    final int price;
    final int discount;
    final int instock;
    final String productDetail;
    final String color;
    final bool isArrival;
    final bool isHotProduct;
    final String image;
    final int isFaverite;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int groupId;
    final int categoryId;
    final int brandId;
    final int creatorId;
    final Brand category;
    final Brand group;
    final Brand brand;
    final Creator creator;
    final List<Imagedetail> imagedetails;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productCode: json["productCode"],
        productName: json["productName"],
        qty: json["qty"],
        price: json["price"],
        discount: json["discount"],
        instock: json["instock"],
        productDetail: json["productDetail"],
        color: json["color"],
        isArrival: json["isArrival"],
        isHotProduct: json["isHotProduct"],
        image: json["image"],
        isFaverite: json["isFaverite"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        groupId: json["groupId"],
        categoryId: json["categoryId"],
        brandId: json["brandId"],
        creatorId: json["creatorId"],
        category: Brand.fromJson(json["category"]),
        group: Brand.fromJson(json["group"]),
        brand: Brand.fromJson(json["brand"]),
        creator: Creator.fromJson(json["creator"]),
        imagedetails: List<Imagedetail>.from(json["imagedetails"].map((x) => Imagedetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productCode": productCode,
        "productName": productName,
        "qty": qty,
        "price": price,
        "discount": discount,
        "instock": instock,
        "productDetail": productDetail,
        "color": color,
        "isArrival": isArrival,
        "isHotProduct": isHotProduct,
        "image": image,
        "isFaverite": isFaverite,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "groupId": groupId,
        "categoryId": categoryId,
        "brandId": brandId,
        "creatorId": creatorId,
        "category": category.toJson(),
        "group": group.toJson(),
        "brand": brand.toJson(),
        "creator": creator.toJson(),
        "imagedetails": List<dynamic>.from(imagedetails.map((x) => x.toJson())),
    };
}

class Brand {
    Brand({
       required this.id,
       required this.title,
       required this.imageUrl,
       required this.createdAt,
       required this.updatedAt,
       required this.creatorId,
       required this.category,
       required this.group,
    });

    final int id;
    final String? title;
    final String imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int creatorId;
    final String? category;
    final String? group;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"] == "" ? "" : json["title"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        creatorId: json["creatorId"],
        category: json["category"] == "" ? "" : json["category"],
        group: json["group"] == "" ? "" : json["group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == "" ? "" : title,
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "creatorId": creatorId,
        "category": category == "" ? "" : category,
        "group": group == "" ? "" : group,
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

class Imagedetail {
    Imagedetail({
      required this.id,
      required this.image,
      required this.createdAt,
      required this.updatedAt,
      required this.productId,
    });

    final int id;
    final String image;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int productId;

    factory Imagedetail.fromJson(Map<String, dynamic> json) => Imagedetail(
        id: json["id"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "productId": productId,
    };
}
