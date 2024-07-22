import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Passform extends StatelessWidget {
  Passform({
    super.key,
    required this.controller,
    required this.title,
  });
  final TextEditingController controller;
  bool isVisable = true;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: BlocConsumer<SinginCubit, SinginState>(
        listener: (context, state) {
          if (state is ChangeVisability) {
            isVisable = state.isVisable;
          }
        },
        builder: (context, state) {
          return TextFormField(
            obscureText: isVisable,
            keyboardType: TextInputType.emailAddress,
            controller: controller,
            validator: (value) {
              if (value == '')
                return AppStrings.validateemail;
              else if (value!.length < 8) return AppStrings.validatepass;
            },
            style: Fontstylesmanager.welcomeSubTitleStyle
                .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<SinginCubit>(context).visable(isVisable);
                  },
                  icon: isVisable == true
                      ? Icon(
                          size: 22,
                          FontAwesomeIcons.eye,
                          color: Colors.white60,
                        )
                      : Icon(
                          size: 22,
                          FontAwesomeIcons.eyeSlash,
                          color: Colors.white60,
                        )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff333333)),
                  borderRadius: BorderRadius.circular(15)),
              label: Text(
                AppStrings.password,
                style: Fontstylesmanager.textFormStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
