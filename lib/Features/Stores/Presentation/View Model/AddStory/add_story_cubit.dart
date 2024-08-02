import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/main.dart';

part 'add_story_state.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  AddStoryCubit() : super(AddStoryInitial());

  addStory() async {
    File? _image;
    var picked;
    var imagename;
    var imageurl;
    var profilePi = await profilePic!.get('profilePic');
    var backPi = await backPic!.get('backPic');
    var name1 = await fristname!.get('fristName');
    var name2 = await lastname!.get('lastName');
    var userId = Constants().userId;
    try {
      picked = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (picked != null) {
        emit(AddStoryLoading());

        _image = File(picked.path);
        var randome = Random().nextInt(1000000);
        imagename = '$randome' + basename(picked.path);
        Reference ref =
            FirebaseStorage.instance.ref('postesImages').child('$imagename');
        await ref.putFile(_image!);
        imageurl = await ref.getDownloadURL();

        Constants().Stores.add({
          'fristName': name1,
          'lastName': name2,
          'userId': userId,
          'store': imageurl,
          'time': '${DateTime.now()}',
          'likes': [],
        });
        emit(AddStorySuccess(url: imageurl));
      }
    } catch (e) {
      emit(AddStoryFailure());
    }
  }
}
