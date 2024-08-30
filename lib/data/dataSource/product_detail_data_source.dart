import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery();
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants();
  Future<List<ProductVariant>> getProductVariants();
}

class ProductDetailRemoteDataSource implements IProductDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="78n4wqor3hhnkju"'};

      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductImage>(
              (jsonObject) => ProductImage.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Variant>> getVariants() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="at0y1gm0t65j62j"'};

      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants() async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants();
    List<ProductVariant> productVarientList = [];

    for (var variantType in variantTypeList) {
      var sortedVariantList = variantList
          .where(
            (element) => element.typeId == variantType.id,
          )
          .toList();

      productVarientList.add(ProductVariant(
          variantType: variantType, variantList: sortedVariantList));
    }
    return productVarientList;
  }
}
