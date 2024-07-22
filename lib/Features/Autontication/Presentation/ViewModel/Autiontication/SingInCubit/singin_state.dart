part of 'singin_cubit.dart';

@immutable
abstract class SinginState {}

class SinginInitial extends SinginState {}

class ChangeLoginState extends SinginState {
  final int index;

  ChangeLoginState({required this.index});
}

class ChangeVisability extends SinginState {
  final bool isVisable;

  ChangeVisability({required this.isVisable});
}

class ChangeSlider extends SinginState {
  final bool offset;

  ChangeSlider({required this.offset});
}
