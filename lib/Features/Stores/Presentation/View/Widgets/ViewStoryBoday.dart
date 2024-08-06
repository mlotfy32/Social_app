import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Stores/Presentation/View%20Model/AddLike/add_like_cubit.dart';
import 'package:social_app/Features/Stores/Presentation/View%20Model/AddStory/add_story_cubit.dart';
import 'package:social_app/Features/Stores/Presentation/View/Widgets/storyContent.dart';
import 'package:social_app/main.dart';

class Viewstoryboday extends StatelessWidget {
  const Viewstoryboday({super.key});

  @override
  Widget build(BuildContext context) {
    Object? profileUrl = profilePic!.get('profilePic');

    return Scaffold(
      body: StreamBuilder(
          stream:
              Constants().Stores.orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Row(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BlocConsumer<AddStoryCubit, AddStoryState>(
                    listener: (context, state) {
                      if (state is AddStorySuccess) {
                        ProfileImage = state.url;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      } else if (state is AddStoryLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(minutes: 1),
                            content: Row(
                              children: [
                                Text(
                                  AppStrings.loading,
                                  style: Fontstylesmanager.welcomeSubTitleStyle,
                                ),
                                CircularProgressIndicator()
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )));
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<AddStoryCubit>(context).addStory();
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.buttonColor,
                          radius: 32,
                          child: CircleAvatar(
                            radius: 30,
                            child: state is AddStoryLoading
                                ? CircularProgressIndicator()
                                : Icon(
                                    FontAwesomeIcons.add,
                                    color: Colors.white,
                                  ),
                            backgroundColor: Colors.blueGrey[900],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: helper.getHeight(0.13, context),
                    width: helper.getscreenWidth(context) - 93,
                    child: Center(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (Jiffy.parse(
                                        snapshot.data!.docs[index].get('time'))
                                    .hour >=
                                24) {
                              var id = snapshot.data!.docs[index].id;
                              Constants().Stores.doc('$id').delete();
                            }
                            return SizedBox(
                              width: 70,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                          isScrollControlled: true,
                                          BlocProvider<AddLikeCubit>(
                                            create: (context) => AddLikeCubit(),
                                            child: StoryContent(
                                              userId: snapshot.data!.docs[index]
                                                  .get('userId'),
                                              likes: snapshot.data!.docs[index]
                                                  .get('likes'),
                                              id: snapshot.data!.docs[index].id,
                                              Index: index,
                                              Url: snapshot.data!.docs[index]
                                                  .get('store'),
                                              time: snapshot.data!.docs[index]
                                                  .get('time'),
                                              name:
                                                  '${snapshot.data!.docs[index].get('fristName')} ${snapshot.data!.docs[index].get('lastName')}',
                                            ),
                                          ));
                                    },
                                    child: Hero(
                                      tag: 'story-',
                                      child: CircleAvatar(
                                          radius: 32,
                                          backgroundColor:
                                              AppColors.buttonColor,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              '${snapshot.data!.docs[index].get('store')}',
                                            ),
                                          )),
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    snapshot.data!.docs[index].get('userId') ==
                                            Constants().userId
                                        ? AppStrings.myStory
                                        : '${snapshot.data!.docs[index].get('fristName')} ${snapshot.data!.docs[index].get('lastName')}',
                                    style: Fontstylesmanager
                                        .welcomeSubTitleStyle
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.white70),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ]);
            } else if (snapshot.hasData && snapshot.data!.docs.length == 0) {
              return Align(
                alignment: Alignment.topLeft,
                child: BlocConsumer<AddStoryCubit, AddStoryState>(
                  listener: (context, state) {
                    if (state is AddStorySuccess) {
                      ProfileImage = state.url;
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<AddStoryCubit>(context).addStory();
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.buttonColor,
                        radius: 32,
                        child: CircleAvatar(
                          radius: 30,
                          child: state is AddStoryLoading
                              ? CircularProgressIndicator()
                              : Icon(
                                  FontAwesomeIcons.add,
                                  color: Colors.white,
                                ),
                          backgroundColor: Colors.blueGrey[900],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: LoadingAnimationWidget.waveDots(
                  color: AppColors.buttonColor, size: 50),
            );
          }),
    );
  }
}
