import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Customereact extends StatefulWidget {
  const Customereact(
      {super.key,
      required this.share,
      required this.likes,
      required this.comments,
      this.snapshot,
      required this.index});
  final int share;
  final int likes;
  final int comments;
  final snapshot;
  final int index;

  @override
  State<Customereact> createState() => _CustomereactState();
}

class _CustomereactState extends State<Customereact> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context).isLike(
        snabshot: widget.snapshot,
        Index: widget.index,
        userId: Constants().userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactCommentCubit, ReactCommentState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topLeft,
          child: ReactComment(
            share: widget.share,
            comment: widget.comments,
            id: widget.snapshot.data!.docs[widget.index].id,
            likes: widget.likes,
            Index: widget.index,
            snapshot: widget.snapshot,
          ),
        );
      },
    );
  }
}
