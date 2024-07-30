import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';

class RowIcon_Text extends StatelessWidget {
  const RowIcon_Text({
    super.key,
    required this.Url,
    required this.title,
    this.onTap,
  });
  final String Url;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white10,
            child: SvgPicture.asset(
              Url,
              width: 50,
              height: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Fontstylesmanager.welcomeSubTitleStyle
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
