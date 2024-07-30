import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_profile_image_state.dart';

class UpdateProfileImageCubit extends Cubit<UpdateProfileImageState> {
  UpdateProfileImageCubit() : super(UpdateProfileImageInitial());
}
