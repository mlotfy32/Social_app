import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addImage/add_image_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addTitle/add_title_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';
import 'package:social_app/main.dart';

class UpdateImage extends StatefulWidget {
  UpdateImage(
      {super.key,
      required this.title,
      required this.id,
      required this.image,
      required this.ptofile,
      required this.backPic});
  final String title;
  final String id;
  final String image;
  final bool ptofile;
  final bool backPic;

  @override
  State<UpdateImage> createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double opacity = 0.3;
    String url = widget.image;
    List<String> Url = [];
    return Material(
      color: Colors.transparent,
      child: Container(
        height: helper.getscreenHeight(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[800]),
        padding: EdgeInsets.only(
          top: 30,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Emailform(
                  onChanged: (value) {
                    if (value != '' || value.isNotEmpty) {
                      BlocProvider.of<AddTitleCubit>(context).opacity(true);
                    } else {
                      BlocProvider.of<AddTitleCubit>(context).opacity(false);
                    }
                  },
                  controller: textEditingController,
                  title: widget.title,
                  icon: IconButton(
                    onPressed: () {},
                    icon: Icon(color: Colors.white, FontAwesomeIcons.faceSmile),
                  ),
                  email: false),
              SizedBox(
                height: helper.getHeight(0.03, context),
              ),
              BlocConsumer<AddImageCubit, AddImageState>(
                listener: (context, state) {
                  if (state is AddImageLoading) {
                    helper.loading();
                  } else if (state is AddImageSuccess) {
                    url = state.imageUrl;
                    Url.add(url);
                    BlocProvider.of<AddTitleCubit>(context).opacity(true);
                    Get.back();
                  }
                },
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: Duration(seconds: 1),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    width: helper.getscreenWidth(context),
                    height: helper.getHeight(0.5, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.cover)),
                  );
                },
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        BlocProvider.of<AddImageCubit>(context)
                            .addImage('camera');
                      },
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        color: AppColors.buttonColor,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<AddImageCubit>(context)
                            .addImage('gallery');
                      },
                      icon: Icon(
                        FontAwesomeIcons.images,
                        color: AppColors.buttonColor,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.video,
                        color: AppColors.buttonColor,
                        size: 25,
                      )),
                ],
              ),
              // Spacer(),
              BlocConsumer<AddTitleCubit, AddTitleState>(
                listener: (context, state) {
                  if (state is AddTitle) {
                    if (state.hasTitle == true)
                      opacity = 1.0;
                    else
                      opacity = 0.3;
                  }
                },
                builder: (context, state) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: CustomeButton(
                        onTap: opacity == 0.3
                            ? null
                            : () async {
                                helper.loading();

                                if (widget.ptofile == true) {
                                  var email =
                                      await emailPrfs!.getString('email');
                                  QuerySnapshot Data = await Constants()
                                      .Profile
                                      .where('email', isEqualTo: '$email')
                                      .get();
                                  String id = Data.docs[0].id;
                                  BlocProvider.of<AddProfileImageCubit>(context)
                                      .updateImage(Url: Url.first);
                                  await Constants()
                                      .Profile
                                      .doc(id)
                                      .update({'profilePic': Url.first});
                                  await profilePic!
                                      .setString('profilePic', '${Url.first}');
                                  await Constants()
                                      .usersPosts
                                      .doc(widget.id)
                                      .update({
                                    'title': textEditingController.text == ''
                                        ? widget.title
                                        : textEditingController.text,
                                    'profilePic':
                                        Url.isEmpty ? widget.image : Url.first
                                  });
                                } else if (widget.backPic == true) {
                                  var email =
                                      await emailPrfs!.getString('email');
                                  QuerySnapshot Data = await Constants()
                                      .Profile
                                      .where('email', isEqualTo: '$email')
                                      .get();
                                  String id = Data.docs[0].id;
                                  await Constants()
                                      .Profile
                                      .doc(id)
                                      .update({'backPic': Url.first});
                                  await backPic!
                                      .setString('backPic', '${Url.first}');

                                  await Constants()
                                      .usersPosts
                                      .doc(widget.id)
                                      .update({
                                    'title': textEditingController.text == ''
                                        ? widget.title
                                        : textEditingController.text,
                                    'backPic':
                                        Url.isEmpty ? widget.image : Url.first
                                  });
                                } else {
                                  await Constants()
                                      .usersPosts
                                      .doc(widget.id)
                                      .update({
                                    'title': textEditingController.text,
                                    'postState':
                                        textEditingController.text == ''
                                            ? 'image'
                                            : 'postimage',
                                    'imageUrl':
                                        Url.isEmpty ? widget.image : Url.first
                                  });
                                }
                                Get.back();
                                Get.back();

                                final player = AudioPlayer();
                                await player.play(AssetSource('done.wav'));
                              },
                        title: AppStrings.update,
                        color: AppColors.buttonColor),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
