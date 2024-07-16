import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Features/Login/Presentation/ViewModel/LoginCubit/login_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Animatedbutton extends StatefulWidget {
  const Animatedbutton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<Animatedbutton> createState() => _AnimatedbuttonState();
}

class _AnimatedbuttonState extends State<Animatedbutton> {
  @override
  Widget build(BuildContext context) {
    bool offset = false;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ChangeSlider) {
          offset = state.offset;
        }
      },
      builder: (context, state) {
        return AnimatedSlide(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOutCirc,
            offset: offset == false ? Offset(0, 0) : Offset(5, -30),
            child: CustomeButton(
              title: AppStrings.lohin,
              onTap: () {
                if (widget.formKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context).slider();
                }
              },
            ));
      },
    );
  }
}
