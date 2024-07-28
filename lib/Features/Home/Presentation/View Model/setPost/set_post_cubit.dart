import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/main.dart';

part 'set_post_state.dart';

class SetPostCubit extends Cubit<SetPostState> {
  SetPostCubit() : super(SetPostInitial());
  addNewPost({
    required String title,
    required BuildContext context,
  }) async {
    emit(SetPostLoading(loading: AppStrings.sharingPost));

    try {
      var profilePi = await profilePic!.get('profilePic');
      var name1 = await fristname!.get('fristName');
      var name2 = await lastname!.get('lastName');

      var userId = await Constants().userId;
      await Constants().search.add({
        'key': '$title',
        'userId': userId,
      });
      await Constants().usersPosts.add({
        'fristName': name1,
        'lastName': name2,
        'userId': userId,
        'postState': 'post',
        'title': title,
        'profilePic': profilePi,
        'time': '${DateTime.now()}',
        'likes': [],
        'comments': []
      });

      emit(SetPostSuccess());

      Get.back();
    } catch (e) {
      log('$e');
      emit(SetPostFailure());
    }
  }

  addNewPostimage({
    required String title,
    required String imageUrl,
  }) async {
    emit(SetPostLoading(loading: AppStrings.sharingPost));
    try {
      var profilePi = await profilePic!.get('profilePic');
      var name1 = await fristname!.get('fristName');
      var name2 = await lastname!.get('lastName');
      var userId = await Constants().userId;
      await Constants().search.add({
        'key': '$title',
        'userId': userId,
      });
      await Constants().usersPosts.add({
        'fristName': name1,
        'lastName': name2,
        'userId': userId,
        'postState': 'postimage',
        'title': title,
        'imageUrl': imageUrl,
        'profilePic': profilePi,
        'time': '${DateTime.now()}',
        'likes': [],
        'comments': []
      });
      emit(SetPostSuccess());
      Get.back();
    } catch (e) {
      log('$e');
      emit(SetPostFailure());
    }
  }

  addNewImage({
    required String imageUrl,
  }) async {
    emit(SetPostLoading(loading: AppStrings.postAdded));
    try {
      var profilePi = await profilePic!.get('profilePic');
      var name1 = await fristname!.get('fristName');
      var name2 = await lastname!.get('lastName');
      var userId = await Constants().userId;
      await Constants().usersPosts.add({
        'fristName': name1,
        'lastName': name2,
        'userId': userId,
        'postState': 'image',
        'imageUrl': imageUrl,
        'profilePic': profilePi,
        'time': '${DateTime.now()}',
        'likes': [],
        'comments': []
      });
      emit(SetPostSuccess());
      Get.back();
    } catch (e) {
      emit(SetPostFailure());
    }
  }
}
