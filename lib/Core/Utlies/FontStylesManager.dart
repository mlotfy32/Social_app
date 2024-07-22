import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';

abstract class Fontstylesmanager {
  static const TextStyle welcomeTitleStyle =
      TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700);
  static const TextStyle buttonTitleStyle =
      TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600);
  static const TextStyle welcomeSubTitleStyle =
      TextStyle(fontSize: 23, color: Colors.grey, fontWeight: FontWeight.w400);
  static const TextStyle coStyle = TextStyle(
      fontSize: 20, color: AppColors.buttonColor, fontWeight: FontWeight.w700);
  static TextStyle textFormStyle = TextStyle(
      fontSize: 18,
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w300);
  static TextStyle textDialogStyle = TextStyle(
      fontSize: 23,
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w400);
}
