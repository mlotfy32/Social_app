import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customeiconbutton extends StatelessWidget {
  const Customeiconbutton({super.key, this.onPressed, required this.icon});
  final void Function()? onPressed;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: CircleAvatar(
          backgroundColor: Colors.black12,
          child: Center(child: IconButton(onPressed: onPressed, icon: icon))),
    );
  }
}
