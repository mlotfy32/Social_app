import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postDetailes.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Poststate extends StatefulWidget {
  Poststate({
    super.key,
    required this.Index,
    required this.snapshot,
    required this.likes,
  });
  final int Index;
  final dynamic snapshot;
  final int likes;
  @override
  State<Poststate> createState() => _PoststateState();
}

class _PoststateState extends State<Poststate> {
  @override
  void initState() {
    BlocProvider.of<ReactCommentCubit>(context).isLike(
        snabshot: widget.snapshot,
        Index: widget.Index,
        userId: Constants().userId);
    super.initState();
  }

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${widget.snapshot.data!.docs[widget.Index].get('title')}',
              textAlign: TextAlign.start,
              style:
                  Fontstylesmanager.welcomeSubTitleStyle.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<ReactCommentCubit, ReactCommentState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomLeft,
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
