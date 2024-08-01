import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_title_state.dart';

class AddTitleCubit extends Cubit<AddTitleState> {
  AddTitleCubit() : super(AddTitleInitial());
  hasTitle(bool x) {
    if (x != false) {
      emit(AddTitle(hasTitle: true));
    } else {
      emit(AddTitle(hasTitle: false));
    }
  }

  opacity(bool x) {
    if (x != false) {
      emit(AddTitle(hasTitle: true));
    } else {
      emit(AddTitle(hasTitle: false));
    }
  }
}
