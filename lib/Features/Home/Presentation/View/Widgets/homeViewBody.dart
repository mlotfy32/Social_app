import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
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
import 'package:social_app/Features/Profile/Presentation/View/Widgets/updateProfileState.dart';
import 'package:social_app/Features/Stores/Presentation/View/View_Story.dart';
import 'package:social_app/Features/Stores/Presentation/View/Widgets/ViewStoryBoday.dart';

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
    _textEditingController.dispose();
    super.dispose();
  }

  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String searchText = '';
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
            height: 8,
          ),
          SizedBox(
              width: helper.getscreenWidth(context) - 4,
              height: helper.getHeight(0.11, context),
              child: ViewStory()),
          SizedBox(
            height: 60,
            child: Material(
              color: Colors.transparent,
              child: AnimSearchBar(
                  closeSearchOnSuffixTap: true,
                  textFieldIconColor: Colors.white,
                  searchIconColor: AppColors.buttonColor,
                  suffixIcon: Icon(FontAwesomeIcons.circleArrowLeft),
                  textFieldColor: Colors.grey[800],
                  color: Colors.white10,
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    color: AppColors.buttonColor,
                  ),
                  width: helper.getscreenWidth(context),
                  textController: _textEditingController,
                  onSuffixTap: () {},
                  onSubmitted: (x) {}),
            ),
          ),
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
                              EdgeInsets.symmetric(horizontal: 50, vertical: 3),
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
                        // String post =
                        //     snapshot.data!.docs[index].get('postState');
                        // int likes =
                        //     snapshot.data!.docs[index].get('likes').length;
                        // int comments =
                        //     snapshot.data!.docs[index].get('comments').length;
                        // log('$post $index');
                        // //     'post')
                        // BlocProvider(
                        //   create: (context) => ReactCommentCubit(),
                        //   child: CustomePost(
                        //       post: post,
                        //       likes: likes,
                        //       comments: comments,
                        //       Index: index,
                        //       snapshot: snapshot),
                        // );
                        if (snapshot.data!.docs[index].get('postState') ==
                            'post') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          int comments =
                              snapshot.data!.docs[index].get('comments').length;
                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Poststate(
                              likes: likes,
                              Index: index,
                              comments: comments,
                              snapshot: snapshot,
                            ),
                          );
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            'image') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          int comments =
                              snapshot.data!.docs[index].get('comments').length;
                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Imagestate(
                              likes: likes,
                              snapshot: snapshot,
                              comments: comments,
                              Index: index,
                            ),
                          );
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            'postimage') {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          int comments =
                              snapshot.data!.docs[index].get('comments').length;
                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Imagepoststate(
                              likes: likes,
                              Index: index,
                              snapshot: snapshot,
                              comments: comments,
                            ),
                          );
                        } else if (snapshot.data!.docs[index]
                                .get('postState') ==
                            "update his profile picture") {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          int comments =
                              snapshot.data!.docs[index].get('comments').length;

                          return BlocProvider<ReactCommentCubit>(
                            create: (context) => ReactCommentCubit(),
                            child: Updateprofilestate(
                              snapshot: snapshot,
                              comments: comments,
                              Index: index,
                              likes: likes,
                            ),
                          );
                        } else {
                          int likes =
                              snapshot.data!.docs[index].get('likes').length;
                          int comments =
                              snapshot.data!.docs[index].get('comments').length;
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

// Widget CustomePost(
//     {required String post,
//     required int likes,
//     required int comments,
//     required Index,
//     required snapshot}) {
//   switch (post) {
//     case 'post':
//       {
//         log('$Index $post');
//         return Poststate(
//             Index: Index, snapshot: snapshot, likes: likes, comments: comments);
//       }
//     case 'image':
//       {
//         log('$Index $post');
//         return Imagestate(
//             snapshot: snapshot, Index: Index, likes: likes, comments: comments);
//       }
//     case 'postimage':
//       {
//         log('$Index $post');
//         return Imagepoststate(
//             snapshot: snapshot, Index: Index, likes: likes, comments: comments);
//       }
//     case 'update his profile picture':
//       {
//         log('$Index $post');

//         return Updateprofilestate(
//             snapshot: snapshot, Index: Index, likes: likes, comments: comments);
//       }
//     case 'update his profile picture':
//       {
//         log('$Index $post');

//         return Updateprofilestate(
//             snapshot: snapshot, Index: Index, likes: likes, comments: comments);
//       }
//     default:
//       return CircleAvatar(
//         radius: 20,
//         backgroundColor: Colors.white,
//       );
//   }
// }
