class BannerModel {
  String? collectionId;
  String? categoryId;
  String? id;
  String? thumbnail;
  BannerModel({
    this.collectionId,
    this.categoryId,
    this.id,
    this.thumbnail,
  });

  factory BannerModel.fromMapJson(Map<String, dynamic> map) {
    return BannerModel(
      collectionId: map['collectionId'],
      categoryId: map['categoryId'],
      id: map['id'],
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['thumbnail']}',
    );
  }
}
