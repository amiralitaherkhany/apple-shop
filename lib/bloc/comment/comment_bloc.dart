import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/models/comment.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository commentRepository;
  CommentBloc({required this.commentRepository}) : super(CommentInitial()) {
    on<CommentRequestData>((event, emit) async {
      emit(CommentLoading());
      var commentList = await commentRepository.getComments(event.productId);
      emit(CommentResponse(commentList: commentList));
    });

    on<CommentPostRequest>(
      (event, emit) async {
        emit(CommentLoading());
        await commentRepository.postComment(event.productId, event.text);
        var commentList = await commentRepository.getComments(event.productId);
        emit(CommentResponse(commentList: commentList));
      },
    );
  }
}
