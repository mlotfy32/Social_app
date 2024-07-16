import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Login/Presentation/ViewModel/LoginCubit/login_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Customeform extends StatelessWidget {
  Customeform({super.key, required this.controller, required this.state});
  final TextEditingController controller;
  bool isVisable = false;
  final String state;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: TextFormField(
          keyboardType: state == 'email'
              ? TextInputType.emailAddress
              : TextInputType.visiblePassword,
          controller: controller,
          validator: state == 'email'
              ? (value) {
                  if (value == '') return AppStrings.validateemail;
                }
              : (value) {
                  if (value == '')
                    return AppStrings.validateemail;
                  else if (value!.length < 8) return AppStrings.validatepass;
                },
          style: Fontstylesmanager.welcomeSubTitleStyle
              .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            suffixIcon: state == 'email'
                ? Icon(
                    size: 22,
                    FontAwesomeIcons.envelope,
                    color: Colors.white60,
                  )
                : BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is ChangeVisability) {
                        isVisable = state.isVisable;
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .visable(isVisable);
                          },
                          icon: Icon(
                            size: 22,
                            isVisable == false
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.white60,
                          ));
                    },
                  ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff333333)),
                borderRadius: BorderRadius.circular(15)),
            label: Text(
              state == 'email' ? AppStrings.email : AppStrings.password,
              style: Fontstylesmanager.textFormStyle,
            ),
          ),
        ),
      ),
    );
  }
}
