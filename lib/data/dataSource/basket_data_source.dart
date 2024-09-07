import 'package:apple_shop/models/card_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);
}

class BasketLocalDataSource implements IBasketDataSource {
  var box = Hive.box<BasketItem>('BasketBox');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }
}
