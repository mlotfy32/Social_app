import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class Applogo extends StatelessWidget {
  const Applogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: helper.getHeight(0.23, context),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            Appassets.logo,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.social,
                style: Fontstylesmanager.buttonTitleStyle,
              ),
              Text(
                AppStrings.app,
                style: Fontstylesmanager.coStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
