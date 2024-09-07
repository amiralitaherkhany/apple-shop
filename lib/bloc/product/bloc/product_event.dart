part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductInitialize extends ProductEvent {
  final String productId;
  final String categoryId;
  ProductInitialize({
    required this.productId,
    required this.categoryId,
  });
}

class ProductAddToBasket extends ProductEvent {
  final Product product;

  ProductAddToBasket({required this.product});
}
