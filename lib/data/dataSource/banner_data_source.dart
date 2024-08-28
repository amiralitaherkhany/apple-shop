import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSource implements IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      if (response.statusCode == 200) {
        return response.data['items']
            .map<BannerModel>(
                (jsonObject) => BannerModel.fromMapJson(jsonObject))
            .toList();
      }
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
    return [];
  }
}
