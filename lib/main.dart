import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Home/Presentation/View/homeView.dart';
import 'package:social_app/Features/Welcme/Presentation/welcomeView.dart';
import 'package:social_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SinginCubit>(
      create: (context) => SinginCubit(),
      child: GetMaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryColor,
              fontFamily: 'NotoSerif'),
          debugShowCheckedModeBanner: false,
          home: Homeview()
          // Welcomeview(),
          ),
    );
  }
}
