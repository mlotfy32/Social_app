import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton(
      {super.key, required this.title, this.onTap, required this.color});
  final void Function()? onTap;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: helper.getscreenWidth(context),
        height: helper.getHeight(0.07, context),
        child: Center(
          child: Text(
            title,
            style: Fontstylesmanager.buttonTitleStyle,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
      ),
    );
  }
}
