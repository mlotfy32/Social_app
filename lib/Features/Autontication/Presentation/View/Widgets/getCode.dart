import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/appLogo.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Getcode extends StatelessWidget {
  Getcode({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Applogo(),
            Container(
              width: helper.getwidth(0.5, context),
              height: helper.getHeight(0.12, context),
              decoration: BoxDecoration(
                  color: Color(0xff333333),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      bottomRight: Radius.circular(55))),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 100,
                height: helper.getHeight(0.1, context),
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Center(
                  child: Text(
                    AppStrings.Code,
                    style: Fontstylesmanager.welcomeSubTitleStyle
                        .copyWith(fontWeight: FontWeight.w500)
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  log('value = $value');
                  if (value!.isEmpty)
                    return AppStrings.validateemail;
                  else
                    return AppStrings.validatecode;
                },
                length: 6,
                controller: _textEditingController,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  inactiveColor: Color(0xff333333),
                  inactiveFillColor: Color(0xff333333),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed: $v");
                },
                onChanged: (value) {
                  log('$value');
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
                appContext: context,
              ),
            ),
            Spacer(),
            CustomeButton(
              title: 'Done',
              onTap: () {
                if (_textEditingController.text.isNotEmpty &&
                    _textEditingController.text.length == 6) {}
              },
            )
          ],
        ),
      ),
    );
  }
}
