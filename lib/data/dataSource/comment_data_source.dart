import 'package:apple_shop/models/comment.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
}

class CommentRemoteDataSource implements ICommentDataSource {
  final Dio dio;

  CommentRemoteDataSource({required this.dio});
  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, String> qParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id'
      };
      var response = await dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
