part of 'tab_bar_cubit.dart';

@immutable
abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class changeTabBar extends TabBarState {
  final int state;

  changeTabBar({required this.state});
}
