import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitial());
  changeState(int index) {
    emit(changeTabBar(state: index));
  }
}
