import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/Core/Utlies/simpleObserver.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/isScroll/is_scroll_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/tabBar_Cubit/tab_bar_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Welcme/Presentation/View/Widgets/intro.dart';
import 'package:social_app/Features/Welcme/Presentation/welcomeView.dart';
import 'package:social_app/firebase_options.dart';

SharedPreferences? fristname;
SharedPreferences? lastname;
SharedPreferences? profilePic;
SharedPreferences? backPic;
var ProfileImage;
var BackImage;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  fristname = await SharedPreferences.getInstance();
  lastname = await SharedPreferences.getInstance();
  profilePic = await SharedPreferences.getInstance();
  backPic = await SharedPreferences.getInstance();
  ProfileImage = await profilePic!.get('profilePic');
  BackImage = await backPic!.get('backPic');

  if (ProfileImage == null) {
    await profilePic!.setString('profilePic', Appassets.profile);
  }
  BackImage = await backPic!.get('backPic');
  log('%%%%%%%%%%%%%%$BackImage');

  if (BackImage == null) {
    await backPic!.setString('backPic', Appassets.profile);
  }
  BackImage = await backPic!.get('backPic');
  log('%%%%%%%%%%%222%%%$BackImage');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = Simpleobserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IsScrollCubit>(
          create: (context) => IsScrollCubit(),
        ),
        BlocProvider<SinginCubit>(
          create: (context) => SinginCubit(),
        ),
        BlocProvider<AddProfileImageCubit>(
          create: (context) => AddProfileImageCubit(),
        )
      ],
      child: GetMaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryColor,
              fontFamily: 'NotoSerif'),
          debugShowCheckedModeBanner: false,
          home: Intro()
          //Homeview()
          // Welcomeview(),
          ),
    );
  }
}
