import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postDetailes.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Imagestate extends StatefulWidget {
  const Imagestate(
      {super.key, required this.Index, this.snapshot, required this.likes});
  final int Index;
  final dynamic snapshot;
  final int likes;

  @override
  State<Imagestate> createState() => _ImagestateState();
}

class _ImagestateState extends State<Imagestate> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context)
        .isLike(snabshot: widget.snapshot, Index: widget.Index);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white10),
      child: Stack(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
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
          Postdetailes(
            Index: widget.Index,
            snapshot: widget.snapshot,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(top: helper.getHeight(0.34, context)),
            child: BlocBuilder<ReactCommentCubit, ReactCommentState>(
              builder: (context, state) {
                return ReactComment(
                  id: widget.snapshot.data!.docs[widget.Index].id,
                  likes: widget.likes,
                  Index: widget.Index,
                  snapshot: widget.snapshot,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
