import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/loginViewBody.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';

class Loginview extends StatelessWidget {
  const Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SinginCubit>(
      create: (context) => SinginCubit(),
      child: Loginviewbody(),
    );
  }
}
