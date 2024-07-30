import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.url,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white10,
      child: SvgPicture.asset(
        url,
        width: 50,
        height: 30,
      ),
    );
  }
}
