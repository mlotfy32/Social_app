import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';

part 'sing_up_state.dart';

class SingUpCubit extends Cubit<SingUpState> {
  SingUpCubit() : super(SingUpInitial());
  singUp(
      String email, String Password, String fristName, String lastName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      Get.back();
      Get.to(() => Homeview(),
          curve: Curves.easeInCirc, duration: Duration(seconds: 1));
      print('Successfully signed up: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        helper.fail('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        helper.fail('The account already exists for that email.');
      } else {
        Get.back();
        helper.fail(AppStrings.Something);
      }
    } catch (e) {
      Get.back();
      helper.fail(AppStrings.Something);
    }
  }
}
