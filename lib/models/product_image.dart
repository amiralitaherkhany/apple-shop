class ProductImage {
  String productId;
  String image;
  ProductImage({
    required this.productId,
    required this.image,
  });

  factory ProductImage.fromMapJson(Map<String, dynamic> map) {
    return ProductImage(
      productId: map['product_id'] ?? '',
      image:
          'https://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['image']}',
    );
  }
}
