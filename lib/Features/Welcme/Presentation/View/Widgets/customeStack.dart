import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class Customestack extends StatelessWidget {
  const Customestack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //photo height = 0.68
        Container(
          width: helper.getscreenWidth(context),
          height: helper.getHeight(0.68, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Appassets.splashImage), fit: BoxFit.fill)),
        ),
        //gradient
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.only(top: helper.getHeight(0.4, context)),
          width: helper.getscreenWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(AppStrings.welcomeTextTitle,
                    textAlign: TextAlign.left,
                    style: Fontstylesmanager.welcomeTitleStyle),
              ),
              Text(AppStrings.welcomeTextSubTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: Fontstylesmanager.welcomeSubTitleStyle),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primaryColor.withOpacity(0.3),
                  AppColors.primaryColor.withOpacity(0.5),
                  AppColors.primaryColor.withOpacity(0.8),
                  AppColors.primaryColor.withOpacity(0.9),
                  AppColors.primaryColor,
                ]),
          ),
        ),
      ],
    );
  }
}
