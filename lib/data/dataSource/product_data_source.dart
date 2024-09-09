import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio dio;

  ProductRemoteDataSource({required this.dio});
  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
      var response = await dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Product>> getHotest() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
      var response = await dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
