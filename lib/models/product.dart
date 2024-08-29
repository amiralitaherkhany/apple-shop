class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String category;
  Product({
    required this.id,
    required this.collectionId,
    required this.thumbnail,
    required this.description,
    required this.discountPrice,
    required this.price,
    required this.popularity,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory Product.fromMapJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      collectionId: map['collectionId'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      description: map['description'] ?? '',
      discountPrice: map['discount_price']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      popularity: map['popularity'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      category: map['category'] ?? '',
    );
  }
}
