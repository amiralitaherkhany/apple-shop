part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeResponseSuccess extends HomeState {
  final Either<String, List<BannerModel>> bannerList;
  final Either<String, List<Category>> categoryList;
  final Either<String, List<Product>> productList;
  final Either<String, List<Product>> productBestSellerList;
  final Either<String, List<Product>> productHottestList;

  HomeResponseSuccess(
      {required this.productBestSellerList,
      required this.productHottestList,
      required this.productList,
      required this.categoryList,
      required this.bannerList});
}
