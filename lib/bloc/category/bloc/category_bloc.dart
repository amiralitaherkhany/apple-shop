import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/category.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoading());
      var response = await _repository.getCategories();
      emit(CategoryResponse(response: response));
    });
  }
}
