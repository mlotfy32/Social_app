import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Core/Utlies/AppAssets.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/animatedButton.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/containerListView.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/emailForm.dart';
import 'package:social_app/Features/Autontication/Presentation/View/Widgets/passForm.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/SingInCubit/singin_cubit.dart';
import 'package:social_app/Features/Autontication/Presentation/ViewModel/Autiontication/singIn/sing_up_cubit.dart';

class Singupviewbody extends StatefulWidget {
  const Singupviewbody({super.key});

  @override
  State<Singupviewbody> createState() => _SingupviewbodyState();
}

class _SingupviewbodyState extends State<Singupviewbody> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fristName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    fristName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Emailform(
              email: false,
              title: AppStrings.fristName,
              icon: IconButton(
                  onPressed: null,
                  icon: Icon(
                    FontAwesomeIcons.user,
                    size: 22,
                    color: Colors.white60,
                  )),
              controller: fristName,
            ),
            Emailform(
              email: false,
              title: AppStrings.lastName,
              icon: IconButton(
                  onPressed: null,
                  icon: Icon(
                    FontAwesomeIcons.userCheck,
                    size: 22,
                    color: Colors.white60,
                  )),
              controller: lastName,
            ),
            Emailform(
              email: true,
              title: AppStrings.email,
              icon: IconButton(
                  onPressed: null,
                  icon: Icon(
                    FontAwesomeIcons.envelope,
                    size: 22,
                    color: Colors.white60,
                  )),
              controller: email,
            ),
            BlocProvider<SinginCubit>(
              create: (context) => SinginCubit(),
              child: Passform(
                controller: password,
                title: AppStrings.password,
              ),
            ),
            BlocProvider<SingUpCubit>(
              create: (context) => SingUpCubit(),
              child: Animatedbutton(
                  formState: 'singup',
                  freistName: fristName,
                  lastName: lastName,
                  formKey: formKey,
                  email: email,
                  password: password),
            ),
          ],
        ),
      ),
    );
  }
}
