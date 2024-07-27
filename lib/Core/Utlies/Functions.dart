import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';

abstract class helper {
  static double getscreenHeight(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return height;
  }

  static double getscreenWidth(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return width;
  }

  static double getHeight(double Heigth, BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * Heigth;
    return height;
  }

  static double getwidth(double Width, BuildContext context) {
    double width = MediaQuery.sizeOf(context).width * Width;
    return width;
  }

  static void loading() {
    Get.defaultDialog(
        radius: 10,
        titlePadding: EdgeInsets.all(20),
        backgroundColor: AppColors.primaryColor,
        title: AppStrings.loading,
        titleStyle: Fontstylesmanager.textDialogStyle,
        content: Material(
          color: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.inkDrop(
              color: AppColors.buttonColor,
              size: 70,
            ),
          ),
        ));
  }

  static void success(String title) {
    Get.defaultDialog(
        radius: 10,
        titlePadding: EdgeInsets.all(20),
        backgroundColor: AppColors.primaryColor,
        title: title,
        titleStyle: Fontstylesmanager.textDialogStyle,
        content: Material(
          color: Colors.transparent,
          child: Center(
              child: Lottie.asset(Appassets.success, width: 150, height: 150)),
        ));
  }

  static void fail(String title) {
    Get.defaultDialog(
        radius: 10,
        titlePadding: EdgeInsets.all(20),
        backgroundColor: AppColors.primaryColor,
        title: title,
        titleStyle: Fontstylesmanager.textDialogStyle,
        content: Material(
          color: Colors.transparent,
          child: Center(
              child: Lottie.asset(Appassets.fail, width: 150, height: 150)),
        ));
  }

  static void snack(String title) {
    Get.snackbar(
      '',
      snackPosition: SnackPosition.BOTTOM,
      '',
      titleText: Text(
        AppStrings.socialApp,
        style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
      ),
      messageText: Text(
        title,
        style: Fontstylesmanager.welcomeSubTitleStyle.copyWith(fontSize: 17),
      ),
    );
  }
}
/*
 String email = _emailController.text.trim();
    ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://<your-app-id>.firebaseapp.com', // رابط إعادة التوجيه
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
      print('Sign-in link sent to $email');
      // حفظ البريد الإلكتروني لاستخدامه لاحقًا عند التحقق من الرابط
    } catch (e) {
      print('Error: $e');
    }
*/