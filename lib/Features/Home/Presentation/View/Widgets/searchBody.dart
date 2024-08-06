import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';

class SearchBody extends StatelessWidget {
  SearchBody({super.key, required this.search});
  final String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        child: StreamBuilder(
            stream: Constants()
                .usersPosts
                .where('title', isEqualTo: search)
                .snapshots(),
            builder: (context, snapshot) {
              String title = 'aa';
              log('====${title.contains('a')}');
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) => Container(
                            width: helper.getwidth(0.4, context),
                            height: helper.getHeight(0.3, context),
                            child: Stack(
                              children: [],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                      itemCount: snapshot.data!.docs.length),
                );
              } else {
                return Center(
                    child: Text(
                  AppStrings.noData,
                  style: Fontstylesmanager.welcomeTitleStyle
                      .copyWith(fontSize: 20),
                ));
              }
              return Center(
                child: LoadingAnimationWidget.waveDots(
                    color: AppColors.buttonColor, size: 80),
              );
            }),
      ),
    );
  }
}
