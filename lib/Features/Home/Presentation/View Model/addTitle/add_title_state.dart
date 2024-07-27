part of 'add_title_cubit.dart';

@immutable
abstract class AddTitleState {}

class AddTitleInitial extends AddTitleState {}

class AddTitle extends AddTitleState {
  final bool hasTitle;

  AddTitle({required this.hasTitle});
}
