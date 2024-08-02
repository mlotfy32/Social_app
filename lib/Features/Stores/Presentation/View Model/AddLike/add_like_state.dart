part of 'add_like_cubit.dart';

@immutable
abstract class AddLikeState {}

class AddLikeInitial extends AddLikeState {}

class AddLikeSuccess extends AddLikeState {
  final bool liked;

  AddLikeSuccess({required this.liked});
}
