import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';

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

  static void snackloading(String title) {
    Get.snackbar(
      '',
      snackPosition: SnackPosition.BOTTOM,
      '',
      titleText: Row(
        children: [
          Image.asset(
            Appassets.logo,
            width: 50,
            height: 50,
          ),
          Text(
            AppStrings.socialApp,
            style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                Fontstylesmanager.welcomeSubTitleStyle.copyWith(fontSize: 17),
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  static void snackfailure(String title) {
    Get.snackbar(
      '',
      snackPosition: SnackPosition.BOTTOM,
      '',
      titleText: SizedBox(
        height: 30,
        child: Row(
          children: [
            Image.asset(
              Appassets.logo,
              width: 40,
              height: 40,
            ),
            Text(
              AppStrings.socialApp,
              style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
      messageText: SizedBox(
        height: 22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 17),
            ),
            Lottie.asset(
              Appassets.fail,
              width: 50,
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  static Future<void> getLikes(
      {required oldsnapshot,
      required int Index,
      required List likes,
      required BuildContext context}) async {
    Get.dialog(Material(
      color: Colors.transparent,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueGrey.withOpacity(0.5)),
          margin: EdgeInsets.symmetric(vertical: 80, horizontal: 10),
          // height: helper.getHeight(0.7, context),
          width: helper.getscreenWidth(context),
          child: ListView.separated(
              itemBuilder: (context, index) {
                var key = likes[index].keys;
                key = key.toString().split('(');
                key = key[1].toString().split(')');
                log('${key[0]}');

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('${likes[index]['${key[0]}'][1]}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${likes[index]['${key[0]}'][0]}',
                      style: Fontstylesmanager.welcomeTitleStyle
                          .copyWith(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: likes.length)),
    ));
  }

  // static Future<void> getComments(
  //     {required oldsnapshot,
  //     required int Index,
  //     required List Comments,
  //     required String id,
  //     required TextEditingController controller,
  //     required BuildContext context}) async {
}
