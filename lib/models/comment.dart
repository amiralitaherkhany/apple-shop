class Comment {
  String text;
  String userId;
  String productId;
  String id;
  Comment({
    required this.text,
    required this.userId,
    required this.productId,
    required this.id,
  });

  factory Comment.fromMapJson(Map<String, dynamic> map) {
    return Comment(
      text: map['text'] ?? '',
      userId: map['user_id'] ?? '',
      productId: map['product_id'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
