class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumbnailUrl;
  String userName;
  Comment({
    required this.text,
    required this.userId,
    required this.productId,
    required this.id,
    required this.userThumbnailUrl,
    required this.userName,
  });

  factory Comment.fromMapJson(Map<String, dynamic> map) {
    return Comment(
      text: map['text'] ?? '',
      userId: map['user_id'] ?? '',
      productId: map['product_id'] ?? '',
      id: map['id'] ?? '',
      userName: map['expand']['user_id']['username'] ?? '',
      userThumbnailUrl:
          'https://startflutter.ir/api/files/${map['expand']['user_id']['collectionId']}/${map['expand']['user_id']['id']}/${map['expand']['user_id']['avatar']}',
    );
  }
}
