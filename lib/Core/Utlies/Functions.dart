import 'package:flutter/material.dart';

abstract class helper {
  static double getscreenHeight(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return height;
  }

  static double getscreenWidth(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return width;
  }

  static double getHeight(double Heigth, BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * Heigth;
    return height;
  }

  static double getwidth(double Width, BuildContext context) {
    double width = MediaQuery.sizeOf(context).width * Width;
    return width;
  }
}
