import 'package:apple_shop/data/dataSource/product_data_source.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHotest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      List<Product> productList = await dataSource.getProducts();
      return right(productList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      List<Product> productList = await dataSource.getBestSeller();
      return right(productList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotest() async {
    try {
      List<Product> productList = await dataSource.getHotest();
      return right(productList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
