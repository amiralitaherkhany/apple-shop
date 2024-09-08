import 'package:apple_shop/data/dataSource/basket_data_source.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
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

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItems = await _dataSource.getAllBasketItems();
      return right(basketItems);
    } catch (e) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return await _dataSource.getBasketFinalPrice();
  }
}
