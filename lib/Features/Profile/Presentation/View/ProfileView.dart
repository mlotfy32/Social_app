import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Home/Presentation/View%20Model/addImage/add_image_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View%20Model/addProfileImage/add_profile_image_cubit.dart';
import 'package:social_app/Features/Profile/Presentation/View/Widgets/profileViewBody.dart';

class Profileview extends StatelessWidget {
  const Profileview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddImageCubit>(
      create: (context) => AddImageCubit(),
      child: Profileviewbody(),
    );
  }
}
