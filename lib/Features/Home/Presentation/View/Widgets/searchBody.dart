import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Constants.dart';

class SearchBody extends StatelessWidget {
  SearchBody({super.key, required this.search});
  final String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        child: StreamBuilder(
            stream:
                Constants().search.where('key', isEqualTo: search).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(child: Text(snapshot.data!.docs[0].get('key')));
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
