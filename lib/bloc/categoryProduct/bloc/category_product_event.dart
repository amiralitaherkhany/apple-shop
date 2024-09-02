part of 'category_product_bloc.dart';

@immutable
sealed class CategoryProductEvent {}

final class CategoryProductRequestData extends CategoryProductEvent {
  final String categoryId;

  CategoryProductRequestData({required this.categoryId});
}
