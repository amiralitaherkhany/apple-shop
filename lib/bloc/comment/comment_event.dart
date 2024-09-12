part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class CommentRequestData extends CommentEvent {
  final String productId;

  CommentRequestData({required this.productId});
}
