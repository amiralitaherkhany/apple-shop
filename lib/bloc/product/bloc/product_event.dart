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
