import 'package:app_links/app_links.dart';
import 'package:apple_shop/bloc/authentication/bloc/auth_bloc.dart';
import 'package:apple_shop/bloc/basket/bloc/basket_bloc.dart';
import 'package:apple_shop/bloc/category/bloc/category_bloc.dart';
import 'package:apple_shop/bloc/categoryProduct/bloc/category_product_bloc.dart';
import 'package:apple_shop/bloc/home/bloc/home_bloc.dart';
import 'package:apple_shop/bloc/product/bloc/product_bloc.dart';
import 'package:apple_shop/cubit/basket/cubit/basket_cubit.dart';
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
import 'package:apple_shop/util/payment_handler.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarinpal/zarinpal.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //utils
  await _initComponents();

  //data sources
  _initDataSources();

  // repositories
  _initRepositories();

  //bloc
  _initBlocs();
}

void _initBlocs() {
  locator.registerSingleton<BasketBloc>(
      BasketBloc(paymentHandler: locator.get(), repository: locator.get()));
  locator.registerFactory<AuthBloc>(() => AuthBloc(repository: locator.get()));
  locator.registerFactory<CategoryBloc>(
      () => CategoryBloc(repository: locator.get()));
  locator.registerFactory<CategoryProductBloc>(
      () => CategoryProductBloc(repository: locator.get()));
  locator.registerFactory<ProductBloc>(() => ProductBloc(
      basketRepository: locator.get(), productDetailRepository: locator.get()));
  locator.registerFactory<HomeBloc>(() => HomeBloc(
      bannerRepository: locator.get(),
      categoryRepository: locator.get(),
      productRepository: locator.get()));
  locator.registerSingleton<BasketCubit>(
      BasketCubit(basketRepository: locator.get()));
}

Future<void> _initComponents() async {
  locator.registerSingleton<UrlHandler>(UrlLauncher());
  locator.registerFactory<AppLinks>(() => AppLinks());
  locator.registerFactory<PaymentRequest>(() => PaymentRequest());
  locator.registerSingleton<PaymentHandler>(ZarinpalPaymentHandler(
      urlHandler: locator.get(),
      appLinks: locator.get(),
      paymentRequest: locator.get()));
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

void _initDataSources() {
  locator.registerFactory<IAuthenticationDataSource>(
      () => AuthenticationRemote(dio: locator.get()));
  locator.registerFactory<ICategoryDataSource>(
      () => CategoryRemoteDataSource(dio: locator.get()));
  locator.registerFactory<IBannerDataSource>(
      () => BannerRemoteDataSource(dio: locator.get()));
  locator.registerFactory<IProductDataSource>(
      () => ProductRemoteDataSource(dio: locator.get()));
  locator.registerFactory<IProductDetailDataSource>(
      () => ProductDetailRemoteDataSource(dio: locator.get()));
  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemoteDataSource(dio: locator.get()));
  locator.registerFactory<IBasketDataSource>(() => BasketLocalDataSource());
}

void _initRepositories() {
  locator.registerFactory<IAuthRepository>(
      () => AuthenticationRepository(dataSource: locator.get()));
  locator.registerFactory<ICategoryRepository>(
      () => CategoryRepository(dataSource: locator.get()));
  locator.registerFactory<IBannerRepository>(
      () => BannerRepository(dataSource: locator.get()));
  locator.registerFactory<IProductRepository>(
      () => ProductRepository(dataSource: locator.get()));
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository(dataSource: locator.get()));
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository(dataSource: locator.get()));
  locator.registerFactory<IBasketRepository>(
      () => BasketRepository(dataSource: locator.get()));
}
