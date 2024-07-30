import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View%20Model/Notification_Cubit/notification_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/isScroll/is_scroll_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/tabBar_Cubit/tab_bar_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeButtomBar.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeForm.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/homeAppBar.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imagePostState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imageState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/storys.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/updateProfileState.dart';

class Homeviewbody extends StatefulWidget {
  Homeviewbody({super.key});

  @override
  State<Homeviewbody> createState() => _HomeviewbodyState();
}

class _HomeviewbodyState extends State<Homeviewbody> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value == true) {
        BlocProvider.of<IsScrollCubit>(context).isScroll();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: helper.getscreenWidth(context),
        height: helper.getscreenHeight(context),
        child: ListView(controller: _scrollController, children: [
          BlocProvider<NotificationCubit>(
              create: (context) => NotificationCubit(), child: Homeappbar()),
          SizedBox(
            height: 10,
          ),
          Storys(),
          SizedBox(
            height: 10,
          ),
          Customeform(),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: Constants()
                  .usersPosts
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                Color(0xffFF4E50),
                                Color(0xffF9D423)
                              ])),
                        );
                      },
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
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
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            "update his profile picture") {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Updateprofilestate(
                              snapshot: snapshot,
                              Index: index,
                              likes: likes,
                            ),
                          );
                        } else {
                          return Text('data');
                        }
                      },
                      itemCount: snapshot.data!.docs.length);
                }
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: AppColors.buttonColor, size: 80),
                );
              }),
        ]),
      )),
    );
  }
}
