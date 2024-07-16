part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeLoginState extends LoginState {
  final int index;

  ChangeLoginState({required this.index});
}

class ChangeVisability extends LoginState {
  final bool isVisable;

  ChangeVisability({required this.isVisable});
}

class ChangeSlider extends LoginState {
  final bool offset;

  ChangeSlider({required this.offset});
}
