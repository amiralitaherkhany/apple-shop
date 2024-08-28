import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/models/category.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  HomeBloc() : super(HomeInitial()) {
    on<HomeRequestData>(
      (event, emit) async {
        emit(HomeLoading());
        var bannerList = await _bannerRepository.getBanners();
        var categoryList = await _categoryRepository.getCategories();
        emit(HomeResponseSuccess(
            bannerList: bannerList, categoryList: categoryList));
      },
    );
  }
}
