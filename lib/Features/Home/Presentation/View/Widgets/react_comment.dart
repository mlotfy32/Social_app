import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';

class ReactComment extends StatelessWidget {
  ReactComment(
      {super.key,
      this.snapshot,
      required this.likes,
      required this.id,
      required this.Index});
  final dynamic snapshot;
  final int Index;
  final int likes;
  final String id;
  @override
  Widget build(BuildContext context) {
    bool update = false;
    return Row(
      children: [
        BlocBuilder<ReactCommentCubit, ReactCommentState>(
          builder: (context, state) {
            return SizedBox(
              width: likes == 0 ? 55 : 73,
              child: Stack(
                children: [
                  Customeiconbutton(
                      onPressed: () async {
                        BlocProvider.of<ReactCommentCubit>(context).setReact(
                            index: Index,
                            id: id,
                            snapshot: snapshot,
                            userId: Constants().userId);
                      },
                      icon: Icon(
                        FontAwesomeIcons.solidHeart,
                        color: state is updateReactComment &&
                                    state.isLiked == false ||
                                state is hasLiked && state.isLike == false
                            ? Colors.white
                            : Colors.red,
                        size: 25,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: TextButton(
                        onPressed: () {},
                        child: TweenAnimationBuilder(
                          tween: IntTween(begin: 0, end: likes),
                          duration: Duration(milliseconds: 1500),
                          builder: (context, value, child) {
                            return Text(
                              likes == 0 ? '' : value.toString(),
                              style: Fontstylesmanager.welcomeSubTitleStyle
                                  .copyWith(fontSize: 18),
                            );
                          },
                        )),
                  )
                ],
              ),
            );
          },
        ),
        Customeiconbutton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.commentDots,
              color: Colors.white,
              size: 25,
            )),
        Customeiconbutton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.share,
              color: Colors.white,
              size: 25,
            ))
      ],
    );
  }
}
