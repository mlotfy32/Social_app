import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/main.dart';
part 'add_profile_image_state.dart';

class AddProfileImageCubit extends Cubit<AddProfileImageState> {
  AddProfileImageCubit() : super(AddProfileImageInitial());
  addProfilePic(
      {required String source,
      required String imageState,
      required String title}) async {
    File? _image;
    var picked;
    var imagename;
    var imageurl;
    var profilePi = await profilePic!.get('profilePic');
    var backPi = await backPic!.get('backPic');
    var name1 = await fristname!.get('fristName');
    var name2 = await lastname!.get('lastName');
    var email = await emailPrfs!.get('email');

    var userId = await Constants().userId;
    QuerySnapshot Data =
        await Constants().Profile.where('email', isEqualTo: email).get();
    String id = await Data.docs[0].id;
    if (source == 'camera') {
      try {
        picked = await ImagePicker().pickImage(source: ImageSource.camera);
        if (picked != null) {
          imageState == 'profile'
              ? emit(AddProfileImageLoading())
              : emit(AddBackImageLoading());

          _image = File(picked.path);
          var randome = Random().nextInt(1000000);
          imagename = '$randome' + basename(picked.path);
          Reference ref =
              FirebaseStorage.instance.ref('postesImages').child('$imagename');
          await ref.putFile(_image!);
          imageurl = await ref.getDownloadURL();

          Constants().usersPosts.add({
            'aboutPost': 'update his profile picture',
            'fristName': name1,
            'lastName': name2,
            'userId': userId,
            'title': title,
            'postState': imageState == 'profile'
                ? 'update his profile picture'
                : 'updated his cover photo',
            'profilePic': imageState == 'profile' ? '$imageurl' : '$profilePi',
            'backPic': imageState != 'profile' ? '$imageurl' : '$backPic',
            'time': '${DateTime.now()}',
            'likes': [],
            'comments': []
          });
          if (imageState == 'profile') {
            profilePi = await profilePic!.setString('profilePic', imageurl);
          } else {
            backPi = await backPic!.setString('backPic', imageurl);
          }
          imageState == 'profile'
              ? emit(AddProfileImageSuccess(Url: imageurl))
              : emit(AddBackImageSuccess(Url: imageurl));
        }
      } catch (e) {
        imageState == 'profile'
            ? emit(AddProfileImageFailure())
            : emit(AddBackImageFailure());
      }
    } else {
      try {
        print('============$profilePi');
        print('============$backPic');

        picked = await ImagePicker().pickImage(source: ImageSource.gallery);

        if (picked != null) {
          imageState == 'profile'
              ? emit(AddProfileImageLoading())
              : emit(AddBackImageLoading());
          _image = File(picked.path);
          var randome = Random().nextInt(1000000);
          imagename = '$randome' + basename(picked.path);
          Reference ref =
              FirebaseStorage.instance.ref('postesImages').child('$imagename');
          await ref.putFile(_image!);
          imageurl = await ref.getDownloadURL();

          Constants().usersPosts.add({
            'aboutPost': imageState == 'profile'
                ? 'update his profile picture'
                : 'updated his cover photo',
            'fristName': name1,
            'lastName': name2,
            'userId': userId,
            'title': title,
            'postState': imageState == 'profile'
                ? 'update his profile picture'
                : 'updated his cover photo',
            'profilePic': imageState == 'profile' ? '$imageurl' : '$profilePi',
            'backPic': imageState != 'profile' ? '$imageurl' : '$backPic',
            'time': '${DateTime.now()}',
            'likes': [],
            'comments': []
          });
          if (imageState == 'profile') {
            await profilePic!.setString('profilePic', imageurl);
            Constants().Profile.doc(id).update({'profilePic': imageurl});
          } else {
            await backPic!.setString('backPic', imageurl);
            Constants().Profile.doc(id).update({'backPic': imageurl});
          }
          imageState == 'profile'
              ? emit(AddProfileImageSuccess(Url: imageurl))
              : emit(AddBackImageSuccess(Url: imageurl));
        }
      } catch (e) {
        imageState == 'profile'
            ? emit(AddProfileImageFailure())
            : emit(AddBackImageFailure());
      }
    }
  }
}
