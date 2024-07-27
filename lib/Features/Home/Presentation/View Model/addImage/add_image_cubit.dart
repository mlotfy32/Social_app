import 'dart:io';
import 'dart:math';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(AddImageInitial());
  addImage(String source) async {
    File? _image;
    var picked;
    var imagename;
    var imageurl;
    if (source == 'camera') {
      try {
        picked = await ImagePicker().pickImage(source: ImageSource.camera);
        emit(AddImageLoading());
        if (picked != null) {
          _image = File(picked.path);
          var randome = Random().nextInt(1000000);
          imagename = '$randome' + basename(picked.path);
          Reference ref =
              FirebaseStorage.instance.ref('postesImages').child('$imagename');
          await ref.putFile(_image!);
          imageurl = await ref.getDownloadURL();
          emit(AddImageSuccess(
            imageUrl: imageurl,
          ));
        }
      } catch (e) {
        print('$e');
      }
    } else {
      try {
        picked = await ImagePicker().pickImage(source: ImageSource.gallery);
        emit(AddImageLoading());

        if (picked != null) {
          _image = File(picked.path);
          var randome = Random().nextInt(1000000);
          imagename = '$randome' + basename(picked.path);
          Reference ref =
              FirebaseStorage.instance.ref('postesImages').child('$imagename');
          await ref.putFile(_image!);
          imageurl = await ref.getDownloadURL();
          emit(AddImageSuccess(
            imageUrl: imageurl,
          ));
        }
      } catch (e) {
        print('$e');
      }
    }
  }
}
