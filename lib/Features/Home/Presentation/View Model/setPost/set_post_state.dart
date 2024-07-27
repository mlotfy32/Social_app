part of 'set_post_cubit.dart';

@immutable
abstract class SetPostState {}

class SetPostInitial extends SetPostState {}

class SetPostLoading extends SetPostState {
  final String loading;

  SetPostLoading({required this.loading});
}

class SetPostSuccess extends SetPostState {}

class SetPostFailure extends SetPostState {}
