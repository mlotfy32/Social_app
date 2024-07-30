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
    try {
      QuerySnapshot fetchData = await Constants().usersCollection.get();
      List<QueryDocumentSnapshot> Data = fetchData.docs;
      for (int x = 0; x < Data.length; x++) {
        log('${Constants().userId}');
        if (email == Data[x].get('email') &&
            password == Data[x].get('password')) {
          await fristname!.setString('fristName', Data[x].get('fristName'));
          await lastname!.setString('lastName', Data[x].get('lastName'));
          log('${Data[x].get('fristName')}');
          log('${Data[x].get('lastName')}');
          log('$x');
          break;
        }
      }
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
