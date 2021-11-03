
class PName {
  final String name;
  final num price;

  const PName({
    required this.name,
    required this.price
  });

  static PName fromJson(Map<String, dynamic> json) => PName(
        name: json['productName'],
        price: json['price'],
      );
}
