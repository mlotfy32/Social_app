part of 'add_story_cubit.dart';

@immutable
abstract class AddStoryState {}

class AddStoryInitial extends AddStoryState {}

class AddStoryLoading extends AddStoryState {}

class AddStorySuccess extends AddStoryState {
  final String url;

  AddStorySuccess({required this.url});
}

class AddStoryFailure extends AddStoryState {}
