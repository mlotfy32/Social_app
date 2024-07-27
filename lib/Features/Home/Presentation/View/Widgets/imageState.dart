import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/postDetailes.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/react_comment.dart';

class Imagestate extends StatelessWidget {
  const Imagestate({super.key, required this.Index, this.snapshot});
  final int Index;
  final dynamic snapshot;
  @override
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
                      image: NetworkImage(
                          snapshot.data!.docs[Index].get('imageUrl')),
                      fit: BoxFit.cover)),
            ),
          ),
          Postdetailes(
            Index: Index,
            snapshot: snapshot,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(top: helper.getHeight(0.34, context)),
            child: ReactComment(
              snapshot: snapshot,
            ),
          )
        ],
      ),
    );
  }
}
