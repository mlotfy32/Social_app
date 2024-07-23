import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';

class Customeform extends StatelessWidget {
  const Customeform({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
          style: Fontstylesmanager.coStyle.copyWith(fontSize: 16),
          decoration: InputDecoration(
              fillColor: Color(0xff262626),
              filled: true,
              label: Text(
                AppStrings.search,
                style: Fontstylesmanager.textFormStyle,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.buttonColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(20)),
              suffixIcon: Icon(
                FontAwesomeIcons.search,
                color: AppColors.buttonColor.withOpacity(0.8),
                size: 25,
              ))),
    );
  }
}
