// To parse this JSON data, do
//
//     final carts = cartsFromJson(jsonString);

import 'dart:convert';

List<Carts> cartsFromJson(String str) =>
    List<Carts>.from(json.decode(str).map((x) => Carts.fromJson(x)));

String cartsToJson(List<Carts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carts {
  Carts({
    required this.id,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.productId,
    required this.product,
    required this.user,
  });

  final int id;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int productId;
  final Product product;
  final User user;

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        id: json["id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        productId: json["productId"],
        product: Product.fromJson(json["product"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "productId": productId,
        "product": product.toJson(),
        "user": user.toJson(),
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String phone;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
