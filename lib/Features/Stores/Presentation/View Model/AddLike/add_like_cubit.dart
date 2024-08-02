import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';

part 'add_like_state.dart';

class AddLikeCubit extends Cubit<AddLikeState> {
  AddLikeCubit() : super(AddLikeInitial());
  addLike({required String id, required int index, required List likes}) {
    var userId = Constants().userId;
    if (likes.contains('$userId')) {
      likes.remove('$userId');
      Constants().Stores.doc(id).update({'likes': likes});
      emit(AddLikeSuccess(liked: false));
    } else {
      likes.add('$userId');
      Constants().Stores.doc(id).update({'likes': likes});
      emit(AddLikeSuccess(liked: true));
    }
  }
}
