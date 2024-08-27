import 'package:apple_shop/data/dataSource/authentication_data_source.dart';
import 'package:apple_shop/data/dataSource/category_data_source.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //data sources
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDataSource());

  // repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
}
