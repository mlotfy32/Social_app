import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class Storys extends StatelessWidget {
  const Storys({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: helper.getscreenWidth(context),
      height: helper.getHeight(0.1, context),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(Appassets.splashImage),
                    radius: 36,
                  ),
                  backgroundColor: AppColors.buttonColor,
                  radius: 38,
                ),
              )),
    );
  }
}
