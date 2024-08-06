import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/main.dart';

part 'react_comment_state.dart';

class ReactCommentCubit extends Cubit<ReactCommentState> {
  ReactCommentCubit() : super(ReactCommentInitial());
  setReact(
      {required String id,
      required snapshot,
      required userId,
      required int index}) async {
    var name1 = await fristname!.get('fristName');
    var name2 = await lastname!.get('lastName');
    var profilePi = await profilePic!.get('profilePic');
    List<bool> contain = [];
    List likes = [];
    await Constants().usersPosts.doc(id).get().then((value) {
      likes.addAll(value.get('likes'));
    });
    try {
      if (likes.isEmpty) {
        final AudioPlayer player = AudioPlayer();
        player.play(AssetSource('like.wav'));
        await Constants().usersPosts.doc(id).update({
          'likes': [
            {
              '$userId': ['$name1 $name2', '$profilePi']
            }
          ],
        });

        emit(updateReactComment(isLiked: true, index: index));

        //notempty
      } else {
        for (int i = 0; i < likes.length; i++) {
          if (likes.isNotEmpty && likes[i].containsKey(userId) == true) {
            log('remove');
            likes.remove(likes[i]);
            await Constants().usersPosts.doc(id).update({'likes': likes});
            emit(updateReactComment(isLiked: false, index: index));
            contain.add(true);
            break;
          }
        }
        if (contain.isEmpty == true) {
          for (int i = 0; i < likes.length; i++) {
            if (likes.isNotEmpty && likes[i].containsKey(userId) == false) {
              log('update');
              log('=$likes=');

              likes.add({
                '$userId': ['$name1 $name2', '$profilePi']
              });
              await Constants().usersPosts.doc(id).update({
                'likes': likes,
              });

              emit(updateReactComment(isLiked: true, index: index));
              break;
            }
          }
        }
      }
    } catch (e) {}
  }

  setComment(
      {required String id,
      required snapshot,
      required userId,
      required String comment,
      required int index}) async {
    var name1 = await fristname!.get('fristName');
    var name2 = await lastname!.get('lastName');
    var profilePi = await profilePic!.get('profilePic');
    List<bool> contain = [];
    List comments = [];
    await Constants().usersPosts.doc(id).get().then((value) {
      comments.addAll(value.get('comments'));
    });
    comments.add({
      '$userId': ['$name1 $name2', '$profilePi', '$comment']
    });
    try {
      await Constants().usersPosts.doc(id).update({'comments': comments});
      emit(updateComment(Comments: comments));
      Get.back();
      final player = AudioPlayer();
      await player.play(AssetSource('done.wav'));
    } catch (e) {}
  }

  removeComment({required List comments, required String id}) async {
    await Constants().usersPosts.doc(id).update({
      'comments': comments,
    });
    emit(updateComment(Comments: comments));
    Get.back();
    final player = AudioPlayer();
    await player.play(AssetSource('done.wav'));
  }

  shareImage(
      {required String id,
      required dynamic oldTime,
      required String name_1,
      required String name_2,
      required String profileUrl,
      required String title,
      required String newState,
      required String imageUrl,
      required String oldUserid,
      required String oldState}) async {
    try {
      helper.loading();
      var name1 = await fristname!.get('fristName');
      var name2 = await lastname!.get('lastName');
      var profilePi = await profilePic!.get('profilePic');
      String userId = Constants().userId;
      var data = await Constants().usersPosts.doc(id).get();
      int share = data.get('share');
      await Constants().usersPosts.doc(id).update({'share': share + 1});
      await Constants().usersPosts.add({
        'oldState': oldState,
        'fristName': name1,
        'lastName': name2,
        'oldName1': name_1,
        'oldName2': name_2,
        'oldUserid': oldUserid,
        'userId': userId,
        'newState': newState,
        'title': title,
        'oldId': id,
        'postState': 'repost this image',
        'imageUrl': imageUrl,
        'profilePic': '$profilePi',
        'backPic': '$backPic',
        'oldTime': '$oldTime',
        'time': '${DateTime.now()}',
        'likes': [],
        'share': 0,
        'comments': []
      });
      final AudioPlayer player = AudioPlayer();
      player.play(AssetSource('done.wav'));
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  sharePost(
      {required String id,
      required dynamic oldTime,
      required String name_1,
      required String name_2,
      required String profileUrl,
      required String oldtitle,
      required String newtitle,
      required String newState,
      required String oldUserid,
      required String oldState}) async {
    try {
      helper.loading();
      var name1 = await fristname!.get('fristName');
      var name2 = await lastname!.get('lastName');
      var profilePi = await profilePic!.get('profilePic');
      String userId = Constants().userId;
      var data = await Constants().usersPosts.doc(id).get();
      int share = data.get('share');
      await Constants().usersPosts.doc(id).update({'share': share + 1});
      await Constants().usersPosts.add({
        'oldState': oldState,
        'fristName': name1,
        'lastName': name2,
        'oldName1': name_1,
        'oldName2': name_2,
        'oldUserid': oldUserid,
        'userId': userId,
        'newState': newState,
        'oldtitle': oldtitle,
        'newtitle': newtitle,
        'oldId': id,
        'postState': 'repost this post',
        'profilePic': '$profilePi',
        'backPic': '$backPic',
        'oldTime': '$oldTime',
        'time': '${DateTime.now()}',
        'likes': [],
        'share': 0,
        'comments': []
      });
      final AudioPlayer player = AudioPlayer();
      player.play(AssetSource('done.wav'));
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  isLike({required snabshot, required int Index, required userId}) async {
    List likes = [];
    List<bool> contain = [];
    await Constants()
        .usersPosts
        .doc(snabshot.data!.docs[Index].id)
        .get()
        .then((value) {
      likes.addAll(value.get('likes'));
    });
    if (likes.isNotEmpty) {
      for (int i = 0; i < likes.length; i++) {
        if (likes[i].containsKey(userId) == true) {
          emit(hasLiked(isLike: true, Index));
          contain.add(true);
          break;
        }
      }
      if (contain.isEmpty) {
        for (int i = 0; i < likes.length; i++) {
          if (likes[i].containsKey(userId) == false) {
            emit(hasLiked(isLike: false, Index));
            break;
          }
        }
      }
    } else {
      emit(hasLiked(isLike: false, Index));
    }
  }
}
