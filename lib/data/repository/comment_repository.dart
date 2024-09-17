import 'package:apple_shop/data/dataSource/comment_data_source.dart';
import 'package:apple_shop/models/comment.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String productId, String text);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      List<Comment> commentList = await dataSource.getComments(productId);
      return right(commentList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String text) async {
    try {
      await dataSource.postComment(productId, text);
      return right('نظر شما اضافه شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
