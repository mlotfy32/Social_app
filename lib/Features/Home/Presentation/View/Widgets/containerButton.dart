import 'package:flutter/material.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton(
      {super.key, this.onTap, required this.color, required this.title});
  final void Function()? onTap;
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              title,
              style: Fontstylesmanager.welcomeSubTitleStyle
                  .copyWith(fontSize: 20, color: Colors.white),
            ),
          ),
          width: 80,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
        ),
      ),
    );
  }
}
