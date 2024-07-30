import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postDetailes.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Updateprofilestate extends StatefulWidget {
  const Updateprofilestate(
      {super.key,
      required this.snapshot,
      required this.Index,
      required this.likes});
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int Index;
  final int likes;

  @override
  State<Updateprofilestate> createState() => _UpdateprofilestateState();
}

class _UpdateprofilestateState extends State<Updateprofilestate> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context).isLike(
        snabshot: widget.snapshot,
        Index: widget.Index,
        userId: Constants().userId);
    super.initState();
  }

  Widget build(BuildContext context) {
    var userData =
        widget.snapshot.data!.docs[widget.Index].data() as Map<String, dynamic>;

    return AnimatedContainer(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white10),
      child: Column(
        children: [
          Postdetailes(
            Index: widget.Index,
            snapshot: widget.snapshot,
          ),
          SizedBox(
            height: 10,
          ),
          widget.snapshot.data!.docs[widget.Index].get('title') == ''
              ? SizedBox()
              : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.snapshot.data!.docs[widget.Index].get('title'),
                    style: Fontstylesmanager.welcomeTitleStyle
                        .copyWith(fontSize: 20),
                  )),
          Text(
            '${userData['likes']}',
            style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
          ),
          InkWell(
              onTap: () {
                Get.bottomSheet(
                    isScrollControlled: true,
                    Container(
                      color: Colors.grey[900],
                      height: helper.getscreenHeight(context),
                      width: helper.getscreenWidth(context),
                      child: PhotoView(
                          filterQuality: FilterQuality.high,
                          imageProvider: NetworkImage(
                              scale: 200,
                              widget.snapshot.data!.docs[widget.Index]
                                  .get('profilePic'))),
                    ));
              },
              child: CircleAvatar(
                radius: 110,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget
                      .snapshot.data!.docs[widget.Index]
                      .get('profilePic')),
                  radius: 107,
                ),
              )),
          BlocBuilder<ReactCommentCubit, ReactCommentState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.topLeft,
                child: ReactComment(
                  id: widget.snapshot.data!.docs[widget.Index].id,
                  likes: widget.likes,
                  Index: widget.Index,
                  snapshot: widget.snapshot,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
