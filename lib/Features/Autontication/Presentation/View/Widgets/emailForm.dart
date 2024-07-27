import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Emailform extends StatelessWidget {
  Emailform(
      {super.key,
      required this.controller,
      this.keyboardType,
      required this.title,
      required this.icon,
      this.onChanged,
      required this.email});
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String title;
  final Icon icon;
  final bool email;
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        validator: (value) {
          if (value == '') return AppStrings.validateemail;
          if (email == true) {
            if (value!.contains('@gmail.com') == false)
              return AppStrings.invaledEmail;
          }
        },
        style: Fontstylesmanager.welcomeSubTitleStyle
            .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff333333)),
              borderRadius: BorderRadius.circular(15)),
          label: Text(
            title,
            style: Fontstylesmanager.textFormStyle,
          ),
        ),
      ),
    );
  }
}
