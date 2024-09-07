import 'package:hive/hive.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0)
class BasketItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  String categoryId;
  @HiveField(7)
  late int realPrice;
  @HiveField(8)
  late num persent;

  BasketItem({
    required this.id,
    required this.collectionId,
    required this.thumbnail,
    required this.discountPrice,
    required this.price,
    required this.name,
    required this.categoryId,
    required this.realPrice,
    required this.persent,
  }) {
    realPrice = price - discountPrice;
    persent = ((price - realPrice) / price) * 100;
  }
  // this.thumbnail =         'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
}
