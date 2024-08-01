import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
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
    log('map likes = ${likes}');
    try {
      if (likes.isEmpty) {
        log('add');
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
  // setReact(
  //     {required String id,
  //     required snapshot,
  //     required userId,
  //     required int index}) async {
  //   List likes = [];
  //   await Constants().usersPosts.doc(id).get().then((value) {
  //     likes.addAll(value.get('likes'));
  //     log('surrent $likes');
  //   });
  //   if (likes.contains(userId)) {
  //     emit(updateReactComment(isLiked: false, index: index));
  //     likes.remove(userId);
  //     await Constants().usersPosts.doc(id).update({
  //       'likes': likes,
  //     });
  //   } else {
  //     emit(updateReactComment(isLiked: true, index: index));
  //     likes.add(userId);
  //     await Constants().usersPosts.doc(id).update({
  //       'likes': likes,
  //     });
  //   }
  //   await Constants().usersPosts.doc(id).get().then((value) {
  //     log('updated ${value.get('likes')}');
  //   });
  // }

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
