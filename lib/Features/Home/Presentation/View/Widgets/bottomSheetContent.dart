import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addImage/add_image_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addTitle/add_title_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/setPost/set_post_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Bottomsheetcontent extends StatefulWidget {
  Bottomsheetcontent({super.key});

  @override
  State<Bottomsheetcontent> createState() => _BottomsheetcontentState();
}

class _BottomsheetcontentState extends State<Bottomsheetcontent> {
  TextEditingController textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';
  bool hasImage = false;
  double opacity = 0.5;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPostCubit, SetPostState>(
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is SetPostLoading ? true : false,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            width: helper.getscreenWidth(context),
            // height: helper.getscreenHeight(context),
            child: ListView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              children: [
                SizedBox(
                  height: 10,
                ),
                Emailform(
                    email: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      if (value == null || value.isEmpty || value == '') {
                        BlocProvider.of<AddTitleCubit>(context).hasTitle(false);
                      } else {
                        BlocProvider.of<AddTitleCubit>(context).hasTitle(true);
                      }
                    },
                    controller: textEditingController,
                    title: AppStrings.mind,
                    icon: IconButton(
                        onPressed: null,
                        icon: Icon(FontAwesomeIcons.faceLaugh))),
                Container(),
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
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<AddImageCubit, AddImageState>(
                  listener: (context, state) {
                    if (state is AddImageSuccess) {
                      imageUrl = state.imageUrl;
                      hasImage = true;
                    }
                  },
                  builder: (context, state) {
                    return state is AddImageLoading
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                              color: AppColors.buttonColor,
                              size: 70,
                            ),
                          )
                        : state is AddImageSuccess
                            ? Container(
                                width: helper.getwidth(0.8, context),
                                height: helper.getHeight(0.5, context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover)),
                              )
                            : state is AddImageFailure
                                ? Center(
                                    child: Column(
                                    children: [
                                      Lottie.asset(Appassets.fail,
                                          height:
                                              helper.getHeight(0.2, context),
                                          width: helper.getwidth(0.5, context)),
                                      Text(
                                        state.error,
                                        style:
                                            Fontstylesmanager.textDialogStyle,
                                      ),
                                    ],
                                  ))
                                : Container(
                                    height: helper.getHeight(0.5, context),
                                  );
                  },
                ),
                BlocConsumer<AddTitleCubit, AddTitleState>(
                  listener: (context, state) {
                    if (state is AddTitle) {
                      if (state.hasTitle == true) {
                        opacity = 1;
                      } else {
                        opacity = 0.5;
                      }
                    }
                  },
                  builder: (context, state) {
                    return BlocConsumer<AddImageCubit, AddImageState>(
                      listener: (context, state) {
                        if (state is AddImageSuccess) {
                          hasImage = true;
                          opacity = 1;
                          imageUrl = state.imageUrl;
                        }
                      },
                      builder: (context, state) {
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 1200),
                          opacity: opacity,
                          child: CustomeButton(
                              color: AppColors.buttonColor.withOpacity(0.8),
                              title: AppStrings.share,
                              onTap: opacity == 0.5 && hasImage == false
                                  ? null
                                  : () async {
                                      if (hasImage == false &&
                                          textEditingController.text != '') {
                                        BlocProvider.of<SetPostCubit>(context)
                                            .addNewPost(
                                                title:
                                                    textEditingController.text,
                                                context: context);
                                      } else if (hasImage == true &&
                                          textEditingController.text == '') {
                                        BlocProvider.of<SetPostCubit>(context)
                                            .addNewImage(imageUrl: imageUrl);
                                      } else {
                                        BlocProvider.of<SetPostCubit>(context)
                                            .addNewPostimage(
                                                title:
                                                    textEditingController.text,
                                                imageUrl: imageUrl);
                                      }
                                    }),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
   if (state is SetPostLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                  duration: Duration(minutes: 10),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.loading,
                        style: TextStyle(fontSize: 18),
                      ),
                      CircularProgressIndicator()
                    ],
                  )))
              .closed;
        } else if (state is SetPostSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.Something,
                        style: TextStyle(fontSize: 18),
                      ),
                      Lottie.asset(Appassets.fail)
                    ],
                  )))
              .closed;
        }
*/





                                 

                                 