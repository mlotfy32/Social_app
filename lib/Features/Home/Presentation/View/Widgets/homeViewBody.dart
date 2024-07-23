import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View%20Model/Notification_Cubit/notification_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/tabBar_Cubit/tab_bar_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeButtomBar.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeForm.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/homeAppBar.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/storys.dart';

class Homeviewbody extends StatelessWidget {
  const Homeviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: helper.getscreenWidth(context),
            height: helper.getscreenHeight(context),
            child: ListView(children: [
              BlocProvider<NotificationCubit>(
                  create: (context) => NotificationCubit(),
                  child: Homeappbar()),
              SizedBox(
                height: 10,
              ),
              Storys(),
              SizedBox(
                height: 10,
              ),
              Customeform()
              // Center(
              //   child: LoadingAnimationWidget.waveDots(
              //       color: AppColors.buttonColor, size: 80),
              // ),
            ]),
          ),
        ],
      )),
    );
  }
}
