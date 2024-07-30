part of 'add_profile_image_cubit.dart';

@immutable
abstract class AddProfileImageState {}

class AddProfileImageInitial extends AddProfileImageState {}

class AddProfileImageLoading extends AddProfileImageState {}

class AddBackImageLoading extends AddProfileImageState {}

class AddProfileImageSuccess extends AddProfileImageState {
  final String Url;

  AddProfileImageSuccess({required this.Url});
}

class AddBackImageSuccess extends AddProfileImageState {
  final String Url;

  AddBackImageSuccess({required this.Url});
}

class AddProfileImageFailure extends AddProfileImageState {}

class AddBackImageFailure extends AddProfileImageState {}
