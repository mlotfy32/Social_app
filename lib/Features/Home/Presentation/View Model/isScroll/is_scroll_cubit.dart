import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'is_scroll_state.dart';

class IsScrollCubit extends Cubit<IsScrollState> {
  IsScrollCubit() : super(IsScrollInitial());
  isScroll() {
    emit(IsScroll(isScroll: true));
    Timer(Duration(seconds: 3), () {
      emit(IsScroll(isScroll: false));
    });
  }
}
