class Category {
  String? collectionId;
  String? color;
  String? icon;
  String? id;
  String? thumbnail;
  String? title;
  Category({
    this.collectionId,
    this.color,
    this.icon,
    this.id,
    this.thumbnail,
    this.title,
  });

  factory Category.fromMapJson(Map<String, dynamic> map) {
    return Category(
      collectionId: map['collectionId'],
      color: map['color'],
      icon:
          'https://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['icon']}',
      id: map['id'],
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['thumbnail']}',
      title: map['title'],
    );
  }
}
