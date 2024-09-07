import 'package:apple_shop/data/dataSource/basket_data_source.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
}

class BasketRepository implements IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      _dataSource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }
}
