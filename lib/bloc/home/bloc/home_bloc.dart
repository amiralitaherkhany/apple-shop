import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final ICategoryRepository categoryRepository;
  final IProductRepository productRepository;
  HomeBloc(
      {required this.bannerRepository,
      required this.categoryRepository,
      required this.productRepository})
      : super(HomeInitial()) {
    on<HomeRequestData>(
      (event, emit) async {
        emit(HomeLoading());
        var bannerList = await bannerRepository.getBanners();
        var categoryList = await categoryRepository.getCategories();
        var productList = await productRepository.getProducts();
        var productHottestList = await productRepository.getHotest();
        var productBestSellerList = await productRepository.getBestSeller();
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
