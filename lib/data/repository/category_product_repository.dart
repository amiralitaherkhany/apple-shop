import 'package:apple_shop/data/dataSource/categort_product_data_source.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId);
}

class CategoryProductRepository implements ICategoryProductRepository {
  final ICategoryProductDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId) async {
    try {
      List<Product> productList =
          await _dataSource.getProductsByCategoryId(categoryId);
      return right(productList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
