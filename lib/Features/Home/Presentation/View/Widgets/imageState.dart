import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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

class Imagestate extends StatefulWidget {
  const Imagestate({
    super.key,
    required this.Index,
    this.snapshot,
    required this.likes,
    required this.comments,
    required this.share,
  });
  final int Index;
  final int comments;
  final dynamic snapshot;
  final int likes;
  final int share;

  @override
  State<Imagestate> createState() => _ImagestateState();
}

class _ImagestateState extends State<Imagestate> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context).isLike(
        snabshot: widget.snapshot,
        Index: widget.Index,
        userId: Constants().userId);
    super.initState();
  }

  BoxDecoration norepost = BoxDecoration(
      borderRadius: BorderRadius.circular(15), color: Colors.white10);
  BoxDecoration repost = BoxDecoration(
      border: Border.all(color: Colors.blueGrey, width: 1),
      borderRadius: BorderRadius.circular(15));
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      padding: widget.snapshot.data!.docs[widget.Index].get('postState') ==
              'repost this image'
          ? EdgeInsets.all(2)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: widget.snapshot.data!.docs[widget.Index].get('postState') ==
              'repost this image'
          ? repost
          : norepost,
      child: Column(
        children: [
          Postdetailes(
            edit: false,
            id: widget.snapshot.data!.docs[widget.Index].id,
            Index: widget.Index,
            snapshot: widget.snapshot,
          ),
          SizedBox(
            height: 10,
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
                          .get('imageUrl')),
                      fit: BoxFit.cover)),
            ),
          ),
          widget.snapshot.data!.docs[widget.Index].get('postState') ==
                  'repost this image'
              ? SizedBox()
              : BlocBuilder<ReactCommentCubit, ReactCommentState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: ReactComment(
                        share: widget.share,
                        comment: widget.comments,
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
