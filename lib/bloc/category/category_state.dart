part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryResponse extends CategoryState {
  final Either<String, List<Category>> response;

  CategoryResponse({required this.response});
}
