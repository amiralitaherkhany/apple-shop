import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();
  CategoryProductBloc() : super(CategoryProductInitial()) {
    on<CategoryProductRequestData>((event, emit) async {
      emit(CategoryProductLoading());
      var productList =
          await _repository.getProductsByCategoryId(event.categoryId);
      emit(CategoryProductResponse(productList: productList));
    });
  }
}
