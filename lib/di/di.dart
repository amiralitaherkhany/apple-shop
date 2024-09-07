import 'package:apple_shop/data/dataSource/authentication_data_source.dart';
import 'package:apple_shop/data/dataSource/banner_data_source.dart';
import 'package:apple_shop/data/dataSource/basket_data_source.dart';
import 'package:apple_shop/data/dataSource/categort_product_data_source.dart';
import 'package:apple_shop/data/dataSource/category_data_source.dart';
import 'package:apple_shop/data/dataSource/product_data_source.dart';
import 'package:apple_shop/data/dataSource/product_detail_data_source.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
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
  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());
  locator.registerFactory<IProductDataSource>(() => ProductRemoteDataSource());
  locator.registerFactory<IProductDetailDataSource>(
      () => ProductDetailRemoteDataSource());
  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemoteDataSource());
  locator.registerFactory<IBasketDataSource>(() => BasketLocalDataSource());

  // repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());
}
