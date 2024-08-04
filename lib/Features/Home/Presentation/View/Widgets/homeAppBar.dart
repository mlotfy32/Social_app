import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View%20Model/Notification_Cubit/notification_cubit.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View/notificationView.dart';

class Homeappbar extends StatefulWidget {
  const Homeappbar({super.key});

  @override
  State<Homeappbar> createState() => _HomeappbarState();
}

class _HomeappbarState extends State<Homeappbar> {
  @override
  void initState() {
    // BlocProvider.of<NotificationCubit>(context).isContainNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: 'logo-',
          child: Image.asset(
            Appassets.logo,
            width: 45,
            height: 45,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 130,
          child: Row(
            children: [
              Text(
                AppStrings.social,
                style: Fontstylesmanager.welcomeTitleStyle,
              ),
              Text(
                AppStrings.app,
                style: Fontstylesmanager.welcomeSubTitleStyle
                    .copyWith(color: AppColors.buttonColor),
              ),
            ],
          ),
        ),
        BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is hasNotification) {
              isEmpty = state.hasnotification;
            }
          },
          builder: (context, state) {
            return isEmpty == false
                ? SizedBox(
                    width: 70,
                    height: 50,
                    child: Center(
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(() => Notificationview(isEmpty: isEmpty),
                                  curve: Curves.easeInCirc,
                                  duration: Duration(seconds: 3));
                            },
                            icon: Icon(
                              FontAwesomeIcons.bell,
                              size: 27,
                              color: AppColors.buttonColor,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, bottom: 20),
                              child: TweenAnimationBuilder(
                                tween: IntTween(
                                  begin: 0,
                                  end: 100,
                                ),
                                duration: Duration(seconds: 3),
                                builder: (context, value, child) {
                                  return Center(
                                    child: Text(
                                      '+$value',
                                      style: Fontstylesmanager
                                          .textnotificationStyle,
                                    ),
                                  );
                                },
                              ))
                        ],
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Get.to(
                        () => Notificationview(isEmpty: isEmpty),
                        curve: Curves.easeInCirc,
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.bell,
                      size: 27,
                      color: AppColors.buttonColor,
                    ),
                  );
          },
        )
      ],
    );
  }
}
/*
    //check is collection empty
              // QuerySnapshot snapshot =
              //     await Constants.notificationCollection.limit(1).get();
              // log('//////////${snapshot.docs.isEmpty}');

              // get content of document[0]
              // log('${value.docs[2].data()}');
              // value.docs.forEach((items) {
              //   if (items.data().isNull) {
              //     log('message');
              //   }
              // data بتجيب الماب كامله
//items.get(Kword) بتجيب الي جوا Kword
              // log('${items.get('hi')[0]}');
*/