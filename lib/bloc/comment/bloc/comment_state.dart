part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentResponse extends CommentState {
  final Either<String, List<Comment>> commentList;

  CommentResponse({required this.commentList});
}
