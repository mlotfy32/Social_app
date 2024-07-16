import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  changeState(int index) {
    emit(ChangeLoginState(index: index));
  }

  visable(isVisable) {
    emit(ChangeVisability(isVisable: !isVisable));
  }

  slider() {
    emit(ChangeSlider(offset: true));
    log('message');
  }
}
