import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();
  HomeBloc() : super(HomeInitial()) {
    on<HomeRequestData>(
      (event, emit) async {
        emit(HomeLoading());
        var bannerList = await _bannerRepository.getBanners();
        var categoryList = await _categoryRepository.getCategories();
        var productList = await _productRepository.getProducts();
        var productHottestList = await _productRepository.getHotest();
        var productBestSellerList = await _productRepository.getBestSeller();
        emit(
          HomeResponseSuccess(
            productList: productList,
            bannerList: bannerList,
            categoryList: categoryList,
            productBestSellerList: productBestSellerList,
            productHottestList: productHottestList,
          ),
        );
      },
    );
  }
}
