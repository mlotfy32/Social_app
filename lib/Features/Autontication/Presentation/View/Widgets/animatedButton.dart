import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/singIn/sing_up_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Animatedbutton extends StatelessWidget {
  const Animatedbutton(
      {required this.formKey,
      required this.email,
      required this.password,
      required this.freistName,
      required this.lastName,
      required this.formState});
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController? freistName;
  final TextEditingController? lastName;
  final String formState;
  @override
  Widget build(BuildContext context) {
    bool offset = false;
    return BlocConsumer<SinginCubit, SinginState>(
      listener: (context, state) {
        if (state is ChangeSlider) {
          offset = state.offset;
        }
      },
      builder: (context, state) {
        return AnimatedSlide(
            duration: Duration(milliseconds: 6000),
            curve: Curves.easeInOutCirc,
            offset: offset == false ? Offset(0, 0) : Offset(5, -800),
            child: CustomeButton(
              title:
                  formState == 'login' ? AppStrings.lohin : AppStrings.singUp,
              onTap: () {
                if (formState == 'login') {
                  if (formKey.currentState!.validate()) {
                    helper.loading(AppStrings.loading);
                    BlocProvider.of<SinginCubit>(context)
                        .sigin(email.text, password.text);
                    BlocProvider.of<SinginCubit>(context).slider();
                  }
                } else {
                  if (formKey.currentState!.validate()) {
                    helper.loading(AppStrings.loading);
                    BlocProvider.of<SingUpCubit>(context).singUp(email.text,
                        password.text, freistName!.text, lastName!.text);
                    BlocProvider.of<SinginCubit>(context).slider();
                  }
                }
              },
            ));
      },
    );
  }
}
