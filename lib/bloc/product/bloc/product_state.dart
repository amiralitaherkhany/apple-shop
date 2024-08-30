part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductResponse extends ProductState {
  final Either<String, List<ProductImage>> productImageList;
  // final Either<String, List<VariantType>> variantTypeList;
  final Either<String, List<ProductVariant>> productVariantList;

  ProductResponse(
      {required this.productImageList, required this.productVariantList});
}
