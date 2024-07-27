part of 'is_scroll_cubit.dart';

@immutable
abstract class IsScrollState {}

class IsScrollInitial extends IsScrollState {}

class IsScroll extends IsScrollState {
  final bool isScroll;

  IsScroll({required this.isScroll});
}
