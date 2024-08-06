import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/commentBody.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class ReactComment extends StatelessWidget {
  ReactComment(
      {super.key,
      required this.snapshot,
      required this.likes,
      required this.id,
      required this.Index,
      required this.comment,
      required this.share});
  final dynamic snapshot;
  final int Index;
  final int likes;
  final String id;
  final int comment;
  final int share;

  TextEditingController textEditingController = TextEditingController();
  @override
  final player = AudioPlayer();
  Widget build(BuildContext context) {
    bool update = false;
    return FittedBox(
      child: AnimatedContainer(
        margin: EdgeInsets.only(top: 5),
        duration: Duration(microseconds: 1500),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.blue.withOpacity(0.03),
              Colors.blue.withOpacity(0.1),
              Colors.blue.withOpacity(0.03),
            ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<ReactCommentCubit, ReactCommentState>(
              builder: (context, state) {
                log('$likes====');

                return SizedBox(
                  width: likes == 0 ? 50 : 73,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Customeiconbutton(
                            onPressed: () async {
                              BlocProvider.of<ReactCommentCubit>(context)
                                  .setReact(
                                      index: Index,
                                      id: id,
                                      snapshot: snapshot,
                                      userId: Constants().userId);
                            },
                            icon: Icon(
                              FontAwesomeIcons.solidHeart,
                              color: state is updateReactComment &&
                                          state.isLiked == false ||
                                      state is hasLiked && state.isLike == false
                                  ? Colors.white
                                  : Colors.red,
                              size: 25,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 45),
                        child: TextButton(
                            onPressed: () {
                              helper.getLikes(
                                  Index: Index,
                                  oldsnapshot: snapshot,
                                  likes:
                                      snapshot.data!.docs[Index].get('likes'),
                                  context: context);
                            },
                            child: TweenAnimationBuilder(
                              tween: IntTween(begin: 0, end: likes),
                              duration: Duration(milliseconds: 1500),
                              builder: (context, value, child) {
                                return Text(
                                  likes == 0 ? '' : value.toString(),
                                  style: Fontstylesmanager.welcomeSubTitleStyle
                                      .copyWith(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w700),
                                );
                              },
                            )),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              width: comment == 0 ? 50 : 90,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Customeiconbutton(
                      icon: Icon(
                        FontAwesomeIcons.commentDots,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () async {
                        List Comments =
                            await snapshot.data!.docs[Index].get('comments');
                        Get.to(() => BlocProvider<ReactCommentCubit>(
                              create: (context) => ReactCommentCubit(),
                              child: Commentbody(
                                  len: comment,
                                  Index: Index,
                                  Comments: Comments,
                                  id: id),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: TextButton(
                        onPressed: () async {
                          List Comments =
                              await snapshot.data!.docs[Index].get('comments');
                          Get.to(() => BlocProvider<ReactCommentCubit>(
                                create: (context) => ReactCommentCubit(),
                                child: Commentbody(
                                    len: comment,
                                    Index: Index,
                                    Comments: Comments,
                                    id: id),
                              ));
                        },
                        child: TweenAnimationBuilder(
                          tween: IntTween(begin: 0, end: comment),
                          duration: Duration(milliseconds: 1500),
                          builder: (context, value, child) {
                            return Text(
                              comment == 0 ? '' : value.toString(),
                              style: Fontstylesmanager.welcomeSubTitleStyle
                                  .copyWith(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              width: share == 0 ? 50 : 90,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Customeiconbutton(
                      icon: Icon(
                        FontAwesomeIcons.share,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () async {
                        if (snapshot.data!.docs[Index].get('postState') !=
                            'post') {
                          Get.bottomSheet(
                              isScrollControlled: true,
                              Container(
                                padding: EdgeInsets.only(
                                    top: 30,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                color: Colors.blueGrey[900],
                                height: helper.getscreenHeight(context),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Emailform(
                                          controller: textEditingController,
                                          title: AppStrings.mind,
                                          icon: IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                FontAwesomeIcons.faceSmile,
                                                color: Colors.blue,
                                              )),
                                          email: false),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        width: helper.getscreenWidth(context),
                                        height: helper.getHeight(0.5, context),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[Index]
                                                      .get('imageUrl'),
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        height: helper.getHeight(0.1, context),
                                      ),
                                      CustomeButton(
                                        title: AppStrings.repost,
                                        color: AppColors.buttonColor,
                                        onTap: () {
                                          BlocProvider.of<ReactCommentCubit>(context).shareImage(
                                              oldState: snapshot.data!.docs[Index]
                                                  .get('aboutPost'),
                                              id: id,
                                              imageUrl: snapshot.data!.docs[Index].get('postState') != 'post'
                                                  ? snapshot.data!.docs[Index]
                                                      .get('imageUrl')
                                                  : '',
                                              name_1: snapshot.data!.docs[Index]
                                                  .get('fristName'),
                                              name_2: snapshot.data!.docs[Index]
                                                  .get('lastName'),
                                              oldTime: snapshot.data!.docs[Index]
                                                  .get('time'),
                                              oldUserid: snapshot.data!.docs[Index]
                                                  .get('userId'),
                                              profileUrl: snapshot.data!.docs[Index]
                                                  .get('profilePic'),
                                              newState: 'repost this ${snapshot.data!.docs[Index].get('postState')}',
                                              title: textEditingController.text);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        } else {
                          Get.bottomSheet(Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey[900]),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Emailform(
                                      controller: textEditingController,
                                      title: AppStrings.mind,
                                      icon: IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            FontAwesomeIcons.faceSmile,
                                            color: Colors.blue,
                                          )),
                                      email: false),
                                  SizedBox(
                                    height: helper.getHeight(0.2, context),
                                  ),
                                  CustomeButton(
                                    title: AppStrings.repost,
                                    color: AppColors.buttonColor,
                                    onTap: () {
                                      BlocProvider.of<ReactCommentCubit>(context).sharePost(
                                          oldState: snapshot.data!.docs[Index]
                                              .get('aboutPost'),
                                          id: id,
                                          name_1: snapshot.data!.docs[Index]
                                              .get('fristName'),
                                          name_2: snapshot.data!.docs[Index]
                                              .get('lastName'),
                                          oldTime: snapshot.data!.docs[Index]
                                              .get('time'),
                                          oldUserid: snapshot.data!.docs[Index]
                                              .get('userId'),
                                          profileUrl: snapshot.data!.docs[Index]
                                              .get('profilePic'),
                                          newState:
                                              'repost this ${snapshot.data!.docs[Index].get('postState')}',
                                          oldtitle: snapshot.data!.docs[Index]
                                              .get('title'),
                                          newtitle: textEditingController.text);
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: TextButton(
                        onPressed: () async {},
                        child: TweenAnimationBuilder(
                          tween: IntTween(begin: 0, end: share),
                          duration: Duration(milliseconds: 1500),
                          builder: (context, value, child) {
                            return Text(
                              share == 0 ? '' : value.toString(),
                              style: Fontstylesmanager.welcomeSubTitleStyle
                                  .copyWith(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
