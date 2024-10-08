import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
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
      var backPi = await backPic!.get('backPic');
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
        'aboutPost': 'set new post',
        'profilePic': '$profilePi',
        'backPic': '$backPic',
        'time': '${DateTime.now()}',
        'share': 0,
        'likes': [],
        'comments': []
      });

      emit(SetPostSuccess());
      final player = AudioPlayer();
      await player.play(AssetSource('done.wav'));
      Get.back();
    } catch (e) {
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
        'aboutPost': 'set new image',
        'imageUrl': imageUrl,
        'profilePic': '$profilePi',
        'backPic': '$backPic',
        'time': '${DateTime.now()}',
        'likes': [],
        'share': 0,
        'comments': []
      });
      emit(SetPostSuccess());
      final player = AudioPlayer();
      await player.play(AssetSource('done.wav'));
      Get.back();
    } catch (e) {
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
        'title': '',
        'fristName': name1,
        'lastName': name2,
        'userId': userId,
        'postState': 'image',
        'aboutPost': 'set new image',
        'imageUrl': imageUrl,
        'profilePic': '$profilePi',
        'backPic': '$backPic',
        'time': '${DateTime.now()}',
        'share': 0,
        'likes': [],
        'comments': []
      });
      emit(SetPostSuccess());
      final player = AudioPlayer();
      await player.play(AssetSource('done.wav'));
      Get.back();
    } catch (e) {
      emit(SetPostFailure());
    }
  }
}
