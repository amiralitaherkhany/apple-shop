part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductResponse extends ProductState {
  final Either<String, List<ProductImage>> productImageList;

  ProductResponse({required this.productImageList});
}
