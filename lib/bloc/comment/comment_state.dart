part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentResponse extends CommentState {
  final Either<String, List<Comment>> commentList;

  CommentResponse({required this.commentList});
}

final class CommentPostLoading extends CommentState {
  final bool isLoading;

  CommentPostLoading({required this.isLoading});
}

final class CommentPostResponse extends CommentState {
  final Either<String, String> response;

  CommentPostResponse({required this.response});
}
