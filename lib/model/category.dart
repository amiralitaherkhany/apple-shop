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

  factory Category.fromMapJson(Map<String, dynamic> jsonObject) {
    return Category(
      collectionId: jsonObject['collectionId'],
      color: jsonObject['color'],
      icon: jsonObject['icon'],
      id: jsonObject['id'],
      thumbnail:
          'https://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      title: jsonObject['title'],
    );
  }
}
