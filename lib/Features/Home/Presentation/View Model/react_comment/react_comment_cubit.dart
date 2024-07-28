import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';

part 'react_comment_state.dart';

class ReactCommentCubit extends Cubit<ReactCommentState> {
  ReactCommentCubit() : super(ReactCommentInitial());
  setReact(
      {required String id,
      required snapshot,
      required userId,
      required int index}) async {
    List likes = [];
    await Constants().usersPosts.doc(id).get().then((value) {
      likes.addAll(value.get('likes'));
      log('surrent $likes');
    });
    if (likes.contains(userId)) {
      emit(updateReactComment(isLiked: false, index: index));
      likes.remove(userId);
      await Constants().usersPosts.doc(id).update({
        'likes': likes,
      });
    } else {
      emit(updateReactComment(isLiked: true, index: index));
      likes.add(userId);
      await Constants().usersPosts.doc(id).update({
        'likes': likes,
      });
    }
    await Constants().usersPosts.doc(id).get().then((value) {
      log('updated ${value.get('likes')}');
    });
  }

  isLike({required snabshot, required int Index}) async {
    List likes = [];
    await Constants()
        .usersPosts
        .doc(snabshot.data!.docs[Index].id)
        .get()
        .then((value) {
      likes.addAll(value.get('likes'));
    });
    if (likes.contains(Constants().userId)) {
      emit(hasLiked(isLike: true, Index));
      log('tttttttttttttt');
    } else {
      emit(hasLiked(isLike: false, Index));
      log('ffffffffffffff');
    }
  }
}
