import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Stores/Presentation/View%20Model/AddStory/add_story_cubit.dart';
import 'package:social_app/Features/Stores/Presentation/View/Widgets/ViewStoryBoday.dart';

class ViewStory extends StatelessWidget {
  const ViewStory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddStoryCubit>(
      create: (context) => AddStoryCubit(),
      child: Viewstoryboday(),
    );
  }
}
