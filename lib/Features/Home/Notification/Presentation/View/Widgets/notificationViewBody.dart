import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View/Widgets/NotificationContent.dart';

class Notificationviewbody extends StatelessWidget {
  const Notificationviewbody({super.key, required this.isEmpty});
  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isEmpty == false
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: Constants()
                    .notificationCollection
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Notificationcontent();
                  } else if (snapshot.hasError) {
                    Center(
                        child: Column(
                      children: [
                        Lottie.asset(Appassets.fail,
                            height: helper.getHeight(0.2, context),
                            width: helper.getwidth(0.5, context)),
                        Text(
                          AppStrings.Something,
                          style: Fontstylesmanager.textDialogStyle,
                        )
                      ],
                    ));
                  }
                  return Center(
                    child: LoadingAnimationWidget.bouncingBall(
                        color: AppColors.buttonColor, size: 100),
                  );
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Appassets.fail,
                      height: helper.getHeight(0.2, context),
                      width: helper.getwidth(0.5, context)),
                  Text(
                    AppStrings.noData,
                    style: Fontstylesmanager.textDialogStyle,
                  )
                ],
              ),
            ),
    );
  }
}
