import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';

class Profileviewbody extends StatelessWidget {
  const Profileviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'profile-${Appassets.profile}',
                child: CircleAvatar(
                  radius: 72,
                  backgroundColor: AppColors.buttonColor,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(Appassets.profile),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
