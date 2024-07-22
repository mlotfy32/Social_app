import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/SingUpView.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/SingUpViewBody.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/appLogo.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/animatedButton.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/containerListView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/loginContent.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/passForm.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Loginviewbody extends StatelessWidget {
  Loginviewbody({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  int bodystate = 0;
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
                    Applogo(),
                    ContainerListView(),
                    BlocConsumer<SinginCubit, SinginState>(
                      listener: (context, state) {
                        if (state is ChangeLoginState) {
                          bodystate = state.index;
                        }
                      },
                      builder: (context, state) {
                        return bodystate == 0
                            ? LogInContent(
                                email: email,
                                password: password,
                                formKey: _formKey)
                            : SizedBox(
                                height: helper.getHeight(0.61, context),
                                child: BlocProvider<SinginCubit>(
                                  create: (context) => SinginCubit(),
                                  child: Singupviewbody(),
                                ));
                      },
                    ),
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
