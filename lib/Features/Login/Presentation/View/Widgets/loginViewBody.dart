import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Login/Presentation/View/Widgets/CustomeForm.dart';
import 'package:social_app/Features/Login/Presentation/View/Widgets/animatedButton.dart';
import 'package:social_app/Features/Login/Presentation/View/Widgets/containerListView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Login/Presentation/ViewModel/LoginCubit/login_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Loginviewbody extends StatelessWidget {
  Loginviewbody({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom * 0.1),
          child: SizedBox(
            height: helper.getscreenHeight(context),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      Appassets.logo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.Media,
                          style: Fontstylesmanager.buttonTitleStyle,
                        ),
                        Text(
                          AppStrings.co,
                          style: Fontstylesmanager.coStyle,
                        )
                      ],
                    ),
                    BlocProvider<LoginCubit>(
                      create: (context) => LoginCubit(),
                      child: ContainerListView(),
                    ),
                    Customeform(
                      controller: email,
                      state: 'email',
                    ),
                    Customeform(
                      controller: password,
                      state: 'pass',
                    ),
                    SizedBox(
                      height: helper.getHeight(0.2, context),
                    ),
                    BlocProvider<LoginCubit>(
                      create: (context) => LoginCubit(),
                      child: Animatedbutton(formKey: _formKey),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
