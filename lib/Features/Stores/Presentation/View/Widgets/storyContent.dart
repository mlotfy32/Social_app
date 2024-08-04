import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Stores/Presentation/View%20Model/AddLike/add_like_cubit.dart';
import 'package:social_app/main.dart';

class StoryContent extends StatefulWidget {
  const StoryContent(
      {super.key,
      required this.id,
      required this.Index,
      required this.Url,
      required this.name,
      this.time,
      required this.likes,
      required this.userId});
  final String id;
  final int Index;
  final String Url;
  final String name;
  final dynamic time;
  final List likes;
  final String userId;

  @override
  State<StoryContent> createState() => _StoryContentState();
}

class _StoryContentState extends State<StoryContent> {
  @override
  Widget build(BuildContext context) {
    bool liked = false;
    Object? profile = profilePic!.getString('profilePic');
    return Container(
      color: Colors.blueGrey[900],
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: helper.getscreenHeight(context),
      width: helper.getscreenWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 3,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 100),
                duration: Duration(seconds: 10),
                builder: (context, value, child) {
                  if (value >= 100.0) {
                    Get.back();
                  }
                  return FAProgressBar(
                    currentValue: value,
                    progressColor: Colors.blue,
                    backgroundColor: Colors.white,
                  );
                },
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('$profile'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.name,
                style:
                    Fontstylesmanager.welcomeTitleStyle.copyWith(fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '${Jiffy.parse(widget.time).fromNow()}',
                style: Fontstylesmanager.welcomeSubTitleStyle
                    .copyWith(fontSize: 12),
              ),
              Spacer(),
              IconButton(
                onPressed: () async {
                  if (Constants().userId == widget.userId) {
                    Get.bottomSheet(Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: helper.getHeight(0.2, context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueGrey[900]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.deletestory,
                            style: Fontstylesmanager.welcomeTitleStyle
                                .copyWith(fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () async {
                                await Constants()
                                    .Stores
                                    .doc(widget.id)
                                    .delete();
                                final AudioPlayer player = AudioPlayer();
                                player.play(AssetSource('done.wav'));
                                Get.back();
                                Get.back();
                              },
                              icon: Icon(
                                FontAwesomeIcons.trash,
                                color: Colors.lightBlue,
                              ))
                        ],
                      ),
                    ));
                  }
                },
                icon: Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Hero(
              tag: 'story-',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(widget.Url), fit: BoxFit.fill),
                ),
                height: helper.getHeight(0.7, context),
                width: helper.getscreenWidth(context),
                child: SizedBox(
                  height: helper.getHeight(0.7, context),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Spacer(),
              BlocConsumer<AddLikeCubit, AddLikeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return BlocConsumer<AddLikeCubit, AddLikeState>(
                    listener: (context, state) {
                      if (state is AddLikeSuccess) {
                        liked = state.liked;
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            BlocProvider.of<AddLikeCubit>(context).addLike(
                                id: widget.id,
                                index: widget.Index,
                                likes: widget.likes);
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: liked == false ? Colors.white : Colors.red,
                            size: 30,
                          ));
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
