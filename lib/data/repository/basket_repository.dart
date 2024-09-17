import 'package:apple_shop/data/dataSource/basket_data_source.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<int> getBasketItemCount();

  Future<void> removeBasketItem(int index);
}

class BasketRepository implements IBasketRepository {
  final IBasketDataSource dataSource;

  BasketRepository({required this.dataSource});

  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      await dataSource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItems = await dataSource.getAllBasketItems();
      return right(basketItems);
    } catch (e) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return await dataSource.getBasketFinalPrice();
  }

  @override
  Future<int> getBasketItemCount() async {
    return await dataSource.getBasketItemCount();
  }

  @override
  Future<void> removeBasketItem(int index) async {
    await dataSource.removeBasketItem(index);
  }
}
