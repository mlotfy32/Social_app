import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postDetailes.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Poststate extends StatelessWidget {
  const Poststate({super.key, required this.Index, required this.snapshot});
  final int Index;
  final dynamic snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white10),
      child: Column(
        children: [
          Postdetailes(
            Index: Index,
            snapshot: snapshot,
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${snapshot.data!.docs[Index].get('title')}',
              textAlign: TextAlign.start,
              style:
                  Fontstylesmanager.welcomeSubTitleStyle.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ReactComment(
            snapshot: snapshot,
          )
        ],
      ),
    );
  }
}
