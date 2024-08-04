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
import 'package:social_app/Features/Home/Presentation/View%20Model/addTitle/add_title_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class EditPost extends StatefulWidget {
  EditPost({super.key, this.title, required this.Index, required this.id});
  final title;
  final int Index;
  final String id;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opacity = 0.3;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey[800]),
      padding: EdgeInsets.symmetric(vertical: 30),
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
          Spacer(),
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
                            QuerySnapshot Data = await Constants()
                                .search
                                .where('title', isEqualTo: widget.title)
                                .get();
                            var id = await Data.docs;
                            Constants()
                                .search
                                .doc('$id')
                                .update({'key': textEditingController.text});
                            Constants().search.doc();
                            helper.loading;
                            Constants().usersPosts.doc(widget.id).update({
                              'title': textEditingController.text,
                            });
                            final player = AudioPlayer();
                            Get.back();
                            await player.play(AssetSource('done.wav'));
                          },
                    title: AppStrings.update,
                    color: AppColors.buttonColor),
              );
            },
          )
        ],
      ),
    );
  }
}
