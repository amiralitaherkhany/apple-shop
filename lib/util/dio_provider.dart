import 'package:apple_shop/util/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readAuth()}'
        },
      ),
    );

    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://startflutter.ir/api/',
    ));

    return dio;
  }
}
