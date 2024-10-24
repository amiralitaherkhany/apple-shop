part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductResponse extends ProductState {
  final Either<String, List<ProductImage>> productImageList;
  // final Either<String, List<VariantType>> variantTypeList;
  final Either<String, List<ProductVariant>> productVariantList;
  final Either<String, List<Property>> productProperties;
  final Either<String, Category> productCategory;
  final bool isAddedtoBasket;
  ProductResponse({
    required this.isAddedtoBasket,
    required this.productCategory,
    required this.productProperties,
    required this.productImageList,
    required this.productVariantList,
  });

  ProductResponse copyWith({
    Either<String, List<ProductImage>>? productImageList,
    Either<String, List<ProductVariant>>? productVariantList,
    Either<String, List<Property>>? productProperties,
    Either<String, Category>? productCategory,
    bool? isAddedtoBasket,
  }) {
    return ProductResponse(
      productImageList: productImageList ?? this.productImageList,
      productVariantList: productVariantList ?? this.productVariantList,
      productProperties: productProperties ?? this.productProperties,
      productCategory: productCategory ?? this.productCategory,
      isAddedtoBasket: isAddedtoBasket ?? this.isAddedtoBasket,
    );
  }
}
