import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Stores/Presentation/View%20Model/AddLike/add_like_cubit.dart';

class StoryContent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    bool liked = false;
    return Container(
      color: Colors.blueGrey[900],
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: helper.getscreenHeight(context),
      width: helper.getscreenWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(Url),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: Fontstylesmanager.welcomeSubTitleStyle
                    .copyWith(fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '${Jiffy.parse(time).fromNow()}',
                style: Fontstylesmanager.welcomeSubTitleStyle
                    .copyWith(fontSize: 18),
              ),
              Spacer(),
              Constants().userId == userId
                  ? IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white60,
                      ),
                      onPressed: () async {
                        await Constants().Stores.doc(id).delete();
                        Get.back();
                      },
                    )
                  : SizedBox()
            ],
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image:
                    DecorationImage(image: NetworkImage(Url), fit: BoxFit.fill),
              ),
              height: helper.getHeight(0.6, context),
              width: helper.getscreenWidth(context),
              child: SizedBox(
                height: helper.getHeight(0.6, context),
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
                            BlocProvider.of<AddLikeCubit>(context)
                                .addLike(id: id, index: Index, likes: likes);
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
