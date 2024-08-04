part of 'react_comment_cubit.dart';

@immutable
abstract class ReactCommentState {}

class ReactCommentInitial extends ReactCommentState {}

class hasLiked extends ReactCommentState {
  final bool isLike;
  final int index;

  hasLiked(this.index, {required this.isLike});
}

class updateReactComment extends ReactCommentState {
  final bool isLiked;
  final int index;

  updateReactComment({required this.isLiked, required this.index});
}

class updateComment extends ReactCommentState {
  final List Comments;

  updateComment({required this.Comments});
}

class Liked extends ReactCommentState {
  final bool like;

  Liked({required this.like});
}
