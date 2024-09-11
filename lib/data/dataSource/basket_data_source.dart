import 'package:apple_shop/models/card_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<int> getBasketItemCount();
}

class BasketLocalDataSource implements IBasketDataSource {
  var box = Hive.box<BasketItem>('BasketBox');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    await box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var basketItems = box.values.toList();
    var finalPrice = basketItems.fold(
      0,
      (previousValue, product) => previousValue + product.realPrice,
    );
    return finalPrice;
  }

  @override
  Future<int> getBasketItemCount() async {
    var basketItemCount = box.values.toList().length;
    return basketItemCount;
  }
}
