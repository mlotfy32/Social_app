part of 'add_image_cubit.dart';

@immutable
abstract class AddImageState {}

class AddImageInitial extends AddImageState {}

class AddImageLoading extends AddImageState {}

class AddImageSuccess extends AddImageState {
  final String imageUrl;
  // final String imageState;

  AddImageSuccess({
    required this.imageUrl,
  });
}

class AddImageFailure extends AddImageState {
  final String error;

  AddImageFailure({required this.error});
}
