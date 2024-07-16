import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/Utlies/AppColors.dart';
import 'package:social_app/Core/Utlies/AppStrings.dart';
import 'package:social_app/Core/Utlies/FontStylesManager.dart';
import 'package:social_app/Core/Utlies/Functions.dart';
import 'package:social_app/Features/Login/Presentation/ViewModel/LoginCubit/login_cubit.dart';

class ContainerListView extends StatelessWidget {
  ContainerListView({super.key});
  BoxDecoration boxDecoration = BoxDecoration(
      color: AppColors.buttonColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60), bottomRight: Radius.circular(60)));
  @override
  Widget build(BuildContext context) {
    int selected = 0;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: helper.getwidth(0.9, context),
      height: helper.getHeight(0.1, context),
      decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(55), bottomRight: Radius.circular(55))),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginCubit>(context).changeState(index);
                },
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is ChangeLoginState) {
                      selected = state.index;
                    }
                  },
                  builder: (context, state) {
                    return AnimatedContainer(
                      duration: Duration(seconds: 2),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: helper.getwidth(0.38, context),
                      height: helper.getHeight(0.001, context),
                      decoration: selected == index ? boxDecoration : null,
                      child: Center(
                        child: Text(
                          AppStrings.singin_upList[index],
                          style: Fontstylesmanager.welcomeSubTitleStyle
                              .copyWith(fontWeight: FontWeight.w500)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              )),
    );
  }
}
