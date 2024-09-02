import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRemoteDataSource implements ICategoryProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Response response;
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get('collections/products/records');
      } else {
        Map<String, String> qParams = {'filter': 'category="$categoryId"'};
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
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
