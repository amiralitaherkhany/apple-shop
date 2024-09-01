import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productDetailRepository = locator.get();

  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialize>((event, emit) async {
      emit(ProductLoading());
      var productImageList =
          await _productDetailRepository.getGallery(event.productId);
      // var variantTypeList = await _productDetailRepository.getVariantTypes();
      var productVariantsList =
          await _productDetailRepository.getProductVariants(event.productId);
      var productCategory =
          await _productDetailRepository.getProductCategory(event.categoryId);
      emit(
        ProductResponse(
          productImageList: productImageList,
          productVariantList: productVariantsList,
          productCategory: productCategory,
        ),
      );
    });
  }
}
