class Price {
  final String type;
  final double price;

  Price({
    required this.type,
    required this.price,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      type: json['type'],
      price: json['price'],
    );
  }
}
