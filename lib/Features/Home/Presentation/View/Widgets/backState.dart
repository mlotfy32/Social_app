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

class BackState extends StatefulWidget {
  const BackState(
      {super.key,
      required this.Index,
      required this.snapshot,
      required this.likes,
      required this.comments});
  final int Index;
  final snapshot;
  final int likes;
  final int comments;

  @override
  State<BackState> createState() => _BackStateState();
}

class _BackStateState extends State<BackState> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context).isLike(
        snabshot: widget.snapshot,
        Index: widget.Index,
        userId: Constants().userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white10),
      child: Column(
        children: [
          Postdetailes(
            id: widget.snapshot.data!.docs[widget.Index].id,
            Index: widget.Index,
            snapshot: widget.snapshot,
          ),
          widget.snapshot.data!.docs[widget.Index].get('title') != ''
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.start,
                      ' ${widget.snapshot.data!.docs[widget.Index].get('title')}',
                      style: Fontstylesmanager.welcomeTitleStyle
                          .copyWith(fontSize: 20),
                    ),
                  ),
                )
              : SizedBox(),
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
                                        .get('postState') ==
                                    'updated his cover photo'
                                ? widget.snapshot.data!.docs[widget.Index]
                                    .get('backPic')
                                : widget.snapshot.data!.docs[widget.Index]
                                    .get('imageUrl'))),
                  ));
            },
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: helper.getscreenWidth(context),
              height: helper.getHeight(0.4, context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(widget
                          .snapshot.data!.docs[widget.Index]
                          .get('backPic')),
                      fit: BoxFit.cover)),
            ),
          ),
          BlocBuilder<ReactCommentCubit, ReactCommentState>(
            builder: (context, state) {
              if (state is hasLiked) {}
              return Align(
                alignment: Alignment.topLeft,
                child: ReactComment(
                  id: widget.snapshot.data!.docs[widget.Index].id,
                  likes: widget.likes,
                  snapshot: widget.snapshot,
                  comment: widget.comments,
                  Index: widget.Index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
