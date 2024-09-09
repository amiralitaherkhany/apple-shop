import 'package:apple_shop/data/dataSource/product_detail_data_source.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_property.dart';
import 'package:apple_shop/models/product_variant.dart';
// import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String productId);
  Future<Either<String, List<Property>>> getProductProperties(String productId);
  // Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
}

class ProductDetailRepository implements IProductDetailRepository {
  final IProductDetailDataSource dataSource;

  ProductDetailRepository({required this.dataSource});
  @override
  Future<Either<String, List<ProductImage>>> getGallery(
      String productId) async {
    try {
      List<ProductImage> productImageList =
          await dataSource.getGallery(productId);
      return right(productImageList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  // @override
  // Future<Either<String, List<VariantType>>> getVariantTypes() async {
  //   try {
  //     List<VariantType> variantTypeList = await _dataSource.getVariantTypes();
  //     return right(variantTypeList);
  //   } on ApiException catch (e) {
  //     return left(e.message ?? 'خطا محتوای متنی ندارد');
  //   }
  // }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      List<ProductVariant> productVariantList =
          await dataSource.getProductVariants(productId);
      return right(productVariantList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      Category productCategory =
          await dataSource.getProductCategory(categoryId);
      return right(productCategory);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(
      String productId) async {
    try {
      List<Property> productProperties =
          await dataSource.getProductProperties(productId);
      return right(productProperties);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
