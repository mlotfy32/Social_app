import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imagePostState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/imageState.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postState.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/updateProfileState.dart';

class ProfilePostes extends StatelessWidget {
  const ProfilePostes({super.key, required this.snapshot});
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: helper.getHeight(0.6, context),
      width: helper.getscreenWidth(context),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Color(0xffFF4E50), Color(0xffF9D423)])),
            );
          },
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (snapshot.data!.docs[index].get('postState') == 'post') {
              int likes = snapshot.data!.docs[index].get('likes').length;
              int comments = snapshot.data!.docs[index].get('comments').length;
              return BlocProvider<ReactCommentCubit>(
                create: (context) => ReactCommentCubit(),
                child: Poststate(
                  likes: likes,
                  comments: comments,
                  Index: index,
                  snapshot: snapshot,
                ),
              );
            } else if (snapshot.data!.docs[index].get('postState') == 'image') {
              int likes = snapshot.data!.docs[index].get('likes').length;
              int comments = snapshot.data!.docs[index].get('comments').length;
              return BlocProvider<ReactCommentCubit>(
                create: (context) => ReactCommentCubit(),
                child: Imagestate(
                  likes: likes,
                  comments: comments,
                  snapshot: snapshot,
                  Index: index,
                ),
              );
            } else if (snapshot.data!.docs[index].get('postState') ==
                'postimage') {
              int likes = snapshot.data!.docs[index].get('likes').length;
              int comments = snapshot.data!.docs[index].get('comments').length;
              return BlocProvider<ReactCommentCubit>(
                create: (context) => ReactCommentCubit(),
                child: Imagepoststate(
                  comments: comments,
                  likes: likes,
                  Index: index,
                  snapshot: snapshot,
                ),
              );
            } else if (snapshot.data!.docs[index].get('postState') ==
                'update his profile picture') {
              int likes = snapshot.data!.docs[index].get('likes').length;
              int comments = snapshot.data!.docs[index].get('comments').length;
              return Updateprofilestate(
                snapshot: snapshot,
                comments: comments,
                Index: index,
                likes: likes,
              );
            } else {}
          },
          itemCount: snapshot.data!.docs.length),
    );
  }
}
