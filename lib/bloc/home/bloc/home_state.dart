part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeResponseSuccess extends HomeState {
  final Either<String, List<BannerModel>> bannerList;
  final Either<String, List<Category>> categoryList;

  HomeResponseSuccess({required this.categoryList, required this.bannerList});
}
