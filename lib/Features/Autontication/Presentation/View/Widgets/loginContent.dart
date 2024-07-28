import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/animatedButton.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/getCode.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/passForm.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class LogInContent extends StatelessWidget {
  LogInContent({
    super.key,
    required this.email,
    required this.password,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> _formKey;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: helper.getHeight(0.48, context),
      child: Column(
        children: [
          Emailform(
            email: true,
            title: AppStrings.email,
            icon: Icon(
              size: 22,
              FontAwesomeIcons.envelope,
              color: Colors.white60,
            ),
            controller: email,
          ),
          BlocProvider<SinginCubit>(
            create: (context) => SinginCubit(),
            child: Passform(
              controller: password,
              title: AppStrings.password,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Get.bottomSheet(Container(
                  width: helper.getscreenWidth(context),
                  height: helper.getHeight(0.5, context),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Emailform(
                          email: true,
                          controller: email,
                          title: AppStrings.email,
                          icon: Icon(
                            size: 22,
                            FontAwesomeIcons.envelope,
                            color: Colors.white60,
                          ),
                        ),
                        Spacer(),
                        CustomeButton(
                          color: AppColors.buttonColor.withOpacity(0.8),
                          title: AppStrings.getCode,
                          onTap: () {
                            int randomNumber = Random().nextInt(1000000);
                            debugPrint('$randomNumber');
                            // if (formKey.currentState!.validate()) {
                            Get.to(() => Getcode());
                            // }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ));
              },
              child: Text(
                AppStrings.forgetPass,
                style: Fontstylesmanager.textFormStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    fontFamily: 'RobotoSlab'),
              ),
            ),
          ),
          Spacer(),
          BlocProvider<SinginCubit>(
            create: (context) => SinginCubit(),
            child: Animatedbutton(
                formState: 'login',
                freistName: null,
                lastName: null,
                formKey: _formKey,
                email: email,
                password: password),
          ),
        ],
      ),
    );
  }
}
