import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';

class ReactComment extends StatelessWidget {
  const ReactComment({super.key, this.snapshot});
  final dynamic snapshot;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Customeiconbutton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.white,
              size: 25,
            )),
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
