import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';
import 'package:social_app/main.dart';

part 'singin_state.dart';

class SinginCubit extends Cubit<SinginState> {
  SinginCubit() : super(SinginInitial());

  sigin(
    String email,
    String password,
  ) async {
    List<String> data = [];
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      QuerySnapshot Data =
          await Constants().Profile.where('email', isEqualTo: email).get();
      List<QueryDocumentSnapshot> snapshot = await Data.docs;
      snapshot.forEach((value) {
        data.add(value.get('fristName'));
        data.add(value.get('lastName'));
      });
      await emailPrfs!.setString('email', email);
      await fristname!.setString('fristname', '${data[0]}');
      await lastname!.setString('lastname', '${data[1]}');
      Get.back();

      Get.offAll(() => Homeview(),
          curve: Curves.easeInCirc, duration: Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.back();

        helper.fail('Please check your email and password.');
      } else if (e.code == 'user-not-found') {
        Get.back();

        helper.fail('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        helper.fail('Wrong email or password');
      } else {
        Get.back();

        helper.fail(AppStrings.Something);
      }
    } catch (e) {
      Get.back();

      helper.fail(AppStrings.Something);
    }
  }

  changeState(int index) {
    log('$index');
    emit(ChangeLoginState(index: index));
  }

  visable(isVisable) {
    emit(ChangeVisability(isVisable: !isVisable));
  }

  slider() {
    emit(ChangeSlider(offset: true));
    log('message');
  }
}
