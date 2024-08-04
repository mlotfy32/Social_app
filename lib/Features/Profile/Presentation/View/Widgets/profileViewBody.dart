import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imagePostState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imageState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postState.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/bottomSheetContent.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/circleIconButton.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/profilePostes.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/rowIcon_Text.dart';
import 'package:social_app/main.dart';

class Profileviewbody extends StatefulWidget {
  Profileviewbody({super.key});

  @override
  State<Profileviewbody> createState() => _ProfileviewbodyState();
}

class _ProfileviewbodyState extends State<Profileviewbody> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  var profileUrl = profilePic!.get('profilePic');
  var backUrl = backPic!.get('backPic');
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: helper.getHeight(0.35, context),
            child: Column(
              children: [
                SizedBox(
                  height: helper.getHeight(0.32, context),
                  width: helper.getscreenWidth(context),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(BottomSheetContent(
                              state: 'back',
                              textEditingController: _textEditingController));
                        },
                        child: BlocConsumer<AddProfileImageCubit,
                            AddProfileImageState>(
                          listener: (context, state) {
                            if (state is AddBackImageLoading) {
                              helper.snackloading(AppStrings.updatingCover);
                            } else if (state is AddBackImageSuccess) {
                              backUrl = state.Url;
                            } else if (state is AddBackImageFailure) {
                              helper.snackfailure(AppStrings.Something);
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              height: helper.getHeight(0.28, context),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("$backUrl"),
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Stack(
                          children: [
                            Hero(
                              transitionOnUserGestures: true,
                              tag: 'profile-',
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.white,
                                  child: BlocConsumer<AddProfileImageCubit,
                                      AddProfileImageState>(
                                    listener: (context, state) {
                                      if (state is AddProfileImageLoading) {
                                        helper.snackloading(
                                            AppStrings.updatingPic);
                                      } else if (state
                                          is AddProfileImageSuccess) {
                                        profileUrl = state.Url;
                                      } else if (state
                                          is AddProfileImageFailure) {
                                        helper
                                            .snackfailure(AppStrings.Something);
                                      }
                                    },
                                    builder: (context, state) {
                                      return CircleAvatar(
                                        radius: 73,
                                        backgroundImage:
                                            NetworkImage('$profileUrl'),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(BottomSheetContent(
                                    state: 'profile',
                                    textEditingController:
                                        _textEditingController));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: helper.getwidth(0.31, context),
                                    top: helper.getHeight(0.13, context)),
                                child: CircleIconButton(
                                  url: Appassets.camera,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            '  ${fristname!.getString('fristName')} ${lastname!.getString('lastName')}',
            style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
              stream: Constants()
                  .usersPosts
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int len = snapshot.data!.docs.length;
                  for (int i = 0; i < len; i++) {
                    String userId = snapshot.data!.docs[i].get('userId');

                    if (userId == Constants().userId) {
                      return BlocProvider<ReactCommentCubit>(
                        create: (context) => ReactCommentCubit(),
                        child: ProfilePostes(
                          snapshot: snapshot,
                        ),
                      );
                    }
                  }
                }
                return Align(
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.waveDots(
                      color: AppColors.buttonColor, size: 80),
                );
              })
        ],
      ),
    );
  }
}




/*
   if (snapshot.data!.docs[index].get('postState') ==
                            'post') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;

                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Poststate(
                              likes: likes,
                              Index: index,
                              snapshot: snapshot,
                            ),
                          );
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            'image') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;

                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Imagestate(
                              likes: likes,
                              snapshot: snapshot,
                              Index: index,
                            ),
                          );
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            'postimage') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;

                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Imagepoststate(
                              likes: likes,
                              Index: index,
                              snapshot: snapshot,
                            ),
                          );
                        } else {
                          return Text('data');
                        }
*/
