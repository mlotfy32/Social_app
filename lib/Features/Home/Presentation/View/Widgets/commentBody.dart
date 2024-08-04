import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/containerButton.dart';

class Commentbody extends StatefulWidget {
  const Commentbody(
      {super.key,
      required this.Index,
      this.oldsnapshot,
      required this.Comments,
      this.snapshot,
      required this.id,
      required this.len});
  final int Index;
  final dynamic oldsnapshot;
  final List Comments;
  final snapshot;
  final String id;
  final int len;
  @override
  State<Commentbody> createState() => _CommentbodyState();
}

class _CommentbodyState extends State<Commentbody> {
  @override
  TextEditingController textEditingController = TextEditingController();
  final ScrollController controller = ScrollController();

  @override
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.Comments.isNotEmpty) {
        controller.animateTo(controller.position.maxScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.bounceInOut);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    List Comment = [];
    Comment.addAll(widget.Comments);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          top: 20,
          right: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey[900]),
        height: helper.getscreenHeight(context),
        width: helper.getscreenWidth(context),
        child: BlocConsumer<ReactCommentCubit, ReactCommentState>(
          listener: (context, state) {
            if (state is updateComment) {
              Comment = [];
              Comment.addAll(state.Comments);
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                Comment.length == 0
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(0.4, context)),
                        child: Center(
                          child: Text(
                            AppStrings.noComments,
                            style: Fontstylesmanager.welcomeTitleStyle,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: helper.getscreenHeight(context) - 130,
                        child: ListView.separated(
                          controller: controller,
                          itemBuilder: (context, index) {
                            var key = Comment[index].keys;
                            key = key.toString().split('(');
                            key = key[1].toString().split(')');

                            return InkWell(
                              onLongPress: () {
                                if (Constants().userId == key[0]) {
                                  Get.defaultDialog(
                                      title:
                                          'delete comment (${Comment[index][key[0]][2]})',
                                      content: Container(
                                        child: SizedBox(
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ContainerButton(
                                                color: Colors.blueGrey,
                                                title: AppStrings.cansel,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                              ContainerButton(
                                                color: Colors.red,
                                                title: AppStrings.delete,
                                                onTap: () async {
                                                  Comment.remove(
                                                      Comment[index]);

                                                  BlocProvider.of<
                                                              ReactCommentCubit>(
                                                          context)
                                                      .removeComment(
                                                          comments: Comment,
                                                          id: widget.id);
                                                  log(Comment.length);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              },
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              '${Comment[index]['${key[0]}'][1]}'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${Comment[index]['${key[0]}'][0]}',
                                          style: Fontstylesmanager
                                              .welcomeTitleStyle
                                              .copyWith(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '${Comment[index]['${key[0]}'][2]}',
                                        style: Fontstylesmanager
                                            .welcomeTitleStyle
                                            .copyWith(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: Comment.length,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Comment.length == 0
                          ? helper.getHeight(0.38, context)
                          : 0),
                  child: SizedBox(
                    height: 77,
                    child: Emailform(
                        controller: textEditingController,
                        title: AppStrings.writeComment,
                        icon: IconButton(
                            onPressed: () {
                              if (textEditingController.text != '') {
                                BlocProvider.of<ReactCommentCubit>(context)
                                    .setComment(
                                        id: widget.id,
                                        snapshot: widget.snapshot,
                                        userId: Constants().userId,
                                        comment: textEditingController.text,
                                        index: widget.Index);
                                helper.loading();
                                textEditingController.clear();
                              }
                            },
                            icon: SvgPicture.asset(Appassets.share)),
                        email: false),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
