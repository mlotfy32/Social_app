import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/loginView.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeStack.dart';

class Welcomeviewbody extends StatelessWidget {
  const Welcomeviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191919),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: helper.getHeight(0.68, context), child: Customestack()),
            Container(
              height: helper.getHeight(0.27, context),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppStrings.aboutApp,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Fontstylesmanager.welcomeSubTitleStyle
                          .copyWith(color: Colors.grey.withOpacity(0.5))),
                  Spacer(),
                  //FixResponsiveButton
                  CustomeButton(
                    color: AppColors.buttonColor.withOpacity(0.8),
                    title: AppStrings.getStart,
                    onTap: () {
                      Get.off(
                        () => Loginview(),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
