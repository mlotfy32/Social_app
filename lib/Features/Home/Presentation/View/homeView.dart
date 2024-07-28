import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/isScroll/is_scroll_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/react_comment/react_comment_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/tabBar_Cubit/tab_bar_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/customeButtomBar.dart';
import 'package:social_app/Features/Home/Presentation/View/Widgets/homeViewBody.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
              height: helper.getscreenHeight(context),
              child: BlocProvider<ReactCommentCubit>(
                create: (context) => ReactCommentCubit(),
                child: Homeviewbody(),
              )),
          BlocProvider<TabBarCubit>(
            create: (context) => TabBarCubit(),
            child: Customebuttombar(),
          )
        ],
      ),
    );
  }
}
