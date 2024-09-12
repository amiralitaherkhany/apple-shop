part of 'category_product_bloc.dart';

@immutable
sealed class CategoryProductState {}

final class CategoryProductInitial extends CategoryProductState {}

final class CategoryProductLoading extends CategoryProductState {}

final class CategoryProductResponse extends CategoryProductState {
  final Either<String, List<Product>> productList;

  CategoryProductResponse({required this.productList});
}
