import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class Notificationcontent extends StatelessWidget {
  const Notificationcontent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: helper.getscreenHeight(context),
      child: ListView.separated(
          itemBuilder: (context, index) => Container(
                height: 80,
                width: helper.getscreenWidth(context),
                // color: Colors.amber,
              ),
          separatorBuilder: (context, index) => Container(
                height: 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [Color(0xff70e1f5), Color(0xffffd194)])),
              ),
          itemCount: 10),
    );
  }
}
