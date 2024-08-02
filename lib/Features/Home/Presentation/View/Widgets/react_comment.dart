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
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/commentBody.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';

class ReactComment extends StatelessWidget {
  ReactComment(
      {super.key,
      this.snapshot,
      required this.likes,
      required this.id,
      required this.Index,
      required this.comment});
  final dynamic snapshot;
  final int Index;
  final int likes;
  final String id;
  final int comment;
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
            Customeiconbutton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.share,
                  color: Colors.white,
                  size: 25,
                ))
          ],
        ),
      ),
    );
  }
}
