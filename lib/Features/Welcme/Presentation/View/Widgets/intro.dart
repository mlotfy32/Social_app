import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  late Animation<double> _animationRotationLogo;
  late Animation<Offset> _animationSlideLogo;
  late AnimationController _animationRotationController;
  late AnimationController _animationSlideController;
  late Animation<double> _animationScaleText;
  late AnimationController _animationScaleController;

  @override
  void initState() {
    _animationRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _animationRotationLogo = Tween<double>(begin: 0.0, end: 3.0).animate(
        CurvedAnimation(
            parent: _animationRotationController, curve: Curves.easeInOutCirc));

    _animationSlideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2200),
    );

    _animationSlideLogo = Tween<Offset>(begin: Offset(0, 10), end: Offset(0, 0))
        .animate(_animationSlideController);

    _animationScaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );

    _animationScaleText = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationScaleController, curve: Curves.easeInOutCirc));

    _animationRotationController.forward();
    _animationSlideController.forward();
    _animationScaleController.forward();
    Timer(
      Duration(seconds: 3),
      () {
        Get.off(() => Homeview(),
            duration: Duration(seconds: 1), curve: Curves.easeIn);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationRotationController.dispose();
    _animationSlideController.dispose();
    _animationScaleController.dispose();
    super.dispose();
  }

  @override
  bool offset = false;
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Hero(
            tag: 'logo-',
            child: SlideTransition(
              position: _animationSlideLogo,
              child: RotationTransition(
                  turns: _animationRotationLogo,
                  child: Image.asset(
                    Appassets.logo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ScaleTransition(
            scale: _animationScaleText,
            child: a(),
          )
        ],
      ),
    );
  }
}

Widget a() {
  return Text(
    AppStrings.socialApp,
    style: Fontstylesmanager.welcomeTitleStyle,
  );
}
