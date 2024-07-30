import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppIcons.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addImage/add_image_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addTitle/add_title_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/isScroll/is_scroll_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/setPost/set_post_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/tabBar_Cubit/tab_bar_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/bottomSheetContent.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View/ProfileView.dart';
import 'package:social_app/main.dart';

class Customebuttombar extends StatelessWidget {
  Customebuttombar({super.key});
  BoxDecoration enableboxDecoration = BoxDecoration(
      color: AppColors.buttonColor, borderRadius: BorderRadius.circular(15));
  BoxDecoration disableboxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(15));
  @override
  var profileUrl = profilePic!.get('profilePic');

  Widget build(BuildContext context) {
    int initialIndex = 0;
    Offset offset = Offset(0, 0);
    double opacity = 1.0;
    return BlocConsumer<IsScrollCubit, IsScrollState>(
      listener: (context, state) {
        if (state is IsScroll) {
          if (state.isScroll == true) {
            offset = Offset(10, 100);
            opacity = 0.0;
          } else {
            offset = Offset(0, 0);
            opacity = 1.0;
          }
        }
      },
      builder: (context, state) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 2000),
          opacity: opacity,
          child: AnimatedSlide(
            duration: Duration(seconds: 1),
            offset: offset,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(colors: [
                      Colors.blue.withOpacity(0.1),
                      Colors.blue.withOpacity(0.2),
                      Colors.blue.withOpacity(0.01),
                    ])),
                width: helper.getscreenWidth(context),
                height: 70,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: AppStrings.tabBartext.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      BlocConsumer<TabBarCubit, TabBarState>(
                    listener: (context, state) {
                      if (state is changeTabBar) {
                        initialIndex = state.state;
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<TabBarCubit>(context)
                                .changeState(index);
                            if (index == 1) {
                              Get.to(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeIn,
                                () => MultiBlocProvider(providers: [
                                  BlocProvider<AddImageCubit>(
                                    create: (context) => AddImageCubit(),
                                  ),
                                  BlocProvider<AddTitleCubit>(
                                    create: (context) => AddTitleCubit(),
                                  ),
                                  BlocProvider<SetPostCubit>(
                                    create: (context) => SetPostCubit(),
                                  )
                                ], child: Bottomsheetcontent()),
                              );
                            }
                          },
                          child: Container(
                              decoration: initialIndex == index
                                  ? enableboxDecoration
                                  : disableboxDecoration,
                              width: initialIndex == index
                                  ? helper.getwidth(0.3, context)
                                  : helper.getwidth(0.2, context),
                              height: helper.getHeight(0.06, context),
                              child: Center(
                                  child: index == 3
                                      ? initialIndex == 3
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      AppColors.buttonColor,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            Appassets.profile),
                                                  ),
                                                ),
                                                Text(
                                                  AppStrings.tabBartext[index],
                                                  style: Fontstylesmanager
                                                      .welcomeTitleStyle
                                                      .copyWith(fontSize: 17),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Get.to(() => Profileview(),
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    curve: Curves.easeInCirc);
                                                log('message');
                                              },
                                              child: Hero(
                                                tag: 'profile-',
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor: Colors.white,
                                                  child: BlocConsumer<
                                                      AddProfileImageCubit,
                                                      AddProfileImageState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is AddProfileImageSuccess) {
                                                        profileUrl = state.Url;
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                '$profileUrl'),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            )
                                      : initialIndex == index
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                AppIcons.tabBarIcons[index],
                                                Text(
                                                  AppStrings.tabBartext[index],
                                                  style: Fontstylesmanager
                                                      .welcomeTitleStyle
                                                      .copyWith(fontSize: 17),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          : index == 1
                                              ? CircleAvatar(
                                                  child: AppIcons
                                                      .tabBarIcons[index],
                                                  radius: 20,
                                                  backgroundColor: Colors.black,
                                                )
                                              : AppIcons.tabBarIcons[index])),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
