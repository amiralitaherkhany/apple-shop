class Banner {
  String? collectionId;
  String? categoryId;
  String? id;
  String? thumbnail;
  Banner({
    this.collectionId,
    this.categoryId,
    this.id,
    this.thumbnail,
  });

  factory Banner.fromMapJson(Map<String, dynamic> map) {
    return Banner(
      collectionId: map['collectionId'],
      categoryId: map['categoryId'],
      id: map['id'],
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['thumbnail']}',
    );
  }
}
