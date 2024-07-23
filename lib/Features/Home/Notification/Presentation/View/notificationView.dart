import 'package:flutter/material.dart';
import 'package:social_app/Features/Home/Notification/Presentation/View/Widgets/notificationViewBody.dart';

class Notificationview extends StatelessWidget {
  const Notificationview({super.key, required this.isEmpty});
  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return Notificationviewbody(
      isEmpty: isEmpty,
    );
  }
}
