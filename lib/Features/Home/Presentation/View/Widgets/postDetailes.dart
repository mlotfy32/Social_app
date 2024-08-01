import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addImage/add_image_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addTitle/add_title_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeIconButton.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/editImage.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/editPost.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/customeButton.dart';

class Postdetailes extends StatelessWidget {
  Postdetailes(
      {super.key, this.snapshot, required this.Index, required this.id});
  final dynamic snapshot;
  final int Index;
  final String id;

  @override
  Widget build(BuildContext context) {
    String _selectedOption = AppStrings.options[0];
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.01),
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                        snapshot.data!.docs[Index].get('profilePic') == null
                            ? Appassets.profile
                            : snapshot.data!.docs[Index].get('profilePic')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: IntrinsicWidth(
                            child: SizedBox(
                              width: helper.getwidth(0.55, context),
                              child: Row(
                                children: [
                                  Text(
                                    '${snapshot.data!.docs[Index].get('fristName')} ${snapshot.data!.docs[Index].get('lastName')}',
                                    style: Fontstylesmanager.welcomeTitleStyle
                                        .copyWith(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              //postState
                            ),
                          ),
                        ),
                        SizedBox(
                          width: helper.getwidth(0.55, context),
                          child: Text(
                            '${snapshot.data!.docs[Index].get('postState')}',
                            style: Fontstylesmanager.welcomeTitleStyle.copyWith(
                                color: Colors.blueGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${Jiffy.parse(snapshot.data!.docs[Index].get('time')).fromNow()}',
                          ),
                        )
                      ]),
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      _selectedOption = result;
                      log('$_selectedOption');
                    },
                    icon: Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
                    itemBuilder: (BuildContext context) => Constants().userId ==
                            snapshot.data!.docs[Index].get('userId')
                        ? <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () {
                                Get.bottomSheet(
                                    isScrollControlled: true,
                                    snapshot.data!.docs[Index]
                                                .get('postState') ==
                                            'post'
                                        ? BlocProvider<AddTitleCubit>(
                                            create: (context) =>
                                                AddTitleCubit(),
                                            child: EditPost(
                                              Index: Index,
                                              id: id,
                                              title: snapshot.data!.docs[Index]
                                                  .get('title'),
                                            ),
                                          )
                                        : MultiBlocProvider(
                                            providers: [
                                              BlocProvider<AddTitleCubit>(
                                                create: (context) =>
                                                    AddTitleCubit(),
                                              ),
                                              BlocProvider<AddImageCubit>(
                                                create: (context) =>
                                                    AddImageCubit(),
                                              ),
                                            ],
                                            child: UpdateImage(
                                              ptofile: snapshot
                                                          .data!.docs[Index]
                                                          .get('postState') ==
                                                      'update his profile picture'
                                                  ? true
                                                  : false,
                                              image: snapshot.data!.docs[Index]
                                                              .get(
                                                                  'postState') ==
                                                          'image' ||
                                                      snapshot.data!.docs[Index]
                                                              .get(
                                                                  'postState') ==
                                                          'postimage'
                                                  ? snapshot.data!.docs[Index]
                                                      .get('imageUrl')
                                                  : snapshot.data!.docs[Index]
                                                      .get('profilePic'),
                                              title: snapshot.data!.docs[Index]
                                                  .get('title'),
                                              id: id,
                                            ),
                                          ));
                              },
                              value: AppStrings.options[0],
                              child: Text('${AppStrings.options[0]}',
                                  style: Fontstylesmanager.welcomeSubTitleStyle
                                      .copyWith(
                                          fontSize: 15, color: Colors.black)),
                            ),
                            PopupMenuItem<String>(
                              onTap: () async {
                                helper.loading();
                                await Constants().usersPosts.doc(id).delete();
                                final player = AudioPlayer();
                                await player.play(AssetSource('done.wav'));
                                Get.back();
                              },
                              value: AppStrings.options[1],
                              child: Text(
                                '${AppStrings.options[1]}',
                                style: Fontstylesmanager.welcomeSubTitleStyle
                                    .copyWith(
                                        fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ]
                        : [],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
