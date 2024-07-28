import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';

class Postdetailes extends StatelessWidget {
  const Postdetailes({super.key, this.snapshot, required this.Index});
  final dynamic snapshot;
  final int Index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.01),
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                        snapshot.data!.docs[Index].get('profilePic') == null
                            ? Appassets.profile
                            : snapshot.data!.docs[Index].get('profilePic')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: IntrinsicWidth(
                            child: SizedBox(
                              width: helper.getwidth(0.55, context),
                              child: Text(
                                '${snapshot.data!.docs[Index].get('fristName')} ${snapshot.data!.docs[Index].get('lastName')}',
                                style: Fontstylesmanager.welcomeTitleStyle
                                    .copyWith(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${Jiffy.parse(snapshot.data!.docs[Index].get('time')).fromNow()}',
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
          Customeiconbutton(
            icon: Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
