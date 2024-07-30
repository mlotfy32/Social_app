import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/rowIcon_Text.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
    required TextEditingController textEditingController,
    required this.state,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      height: helper.getHeight(0.4, context),
      width: helper.getscreenWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.blueGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.chooseSource,
            style: Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 20),
          ),
          Emailform(
              controller: _textEditingController,
              title: AppStrings.mind,
              icon: Icon(FontAwesomeIcons.faceSmile),
              email: false),
          RowIcon_Text(
            Url: Appassets.camera,
            title: AppStrings.fromCamera,
            onTap: () {
              Get.back();
              BlocProvider.of<AddProfileImageCubit>(context).addProfilePic(
                  title: _textEditingController.text,
                  source: 'camera',
                  imageState: state);
            },
          ),
          RowIcon_Text(
            Url: Appassets.gallery,
            title: AppStrings.fromGallery,
            onTap: () {
              Get.back();
              BlocProvider.of<AddProfileImageCubit>(context).addProfilePic(
                  title: _textEditingController.text,
                  source: 'gallery',
                  imageState: state);
            },
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
