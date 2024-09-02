import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/category.dart';
import 'package:apple_shop/models/product_image.dart';
import 'package:apple_shop/models/product_property.dart';
import 'package:apple_shop/models/product_variant.dart';
import 'package:apple_shop/models/variant.dart';
import 'package:apple_shop/models/variant_type.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants(String productId);
  Future<List<ProductVariant>> getProductVariants(String productId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<Property>> getProductProperties(String productId);
}

class ProductDetailRemoteDataSource implements IProductDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

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
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

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
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);
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

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};

      var response = await _dio.get('collections/category/records',
          queryParameters: qParams);
      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Property>> getProductProperties(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Property>((jsonObject) => Property.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
