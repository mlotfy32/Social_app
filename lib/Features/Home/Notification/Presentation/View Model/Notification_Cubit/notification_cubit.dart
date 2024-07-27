import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Core/Utlies/Constants.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  isContainNotification() async {
    //   Map<String, dynamic> map = {'name': 'mhmd', 'phone': 01275348383};
    //   await Constants.notificationCollection.add(map);
    QuerySnapshot fetchData = await Constants().notificationCollection.get();
    QuerySnapshot snapshot =
        await Constants().notificationCollection.limit(1).get();
    bool hasData = await snapshot.docs.isEmpty;
    if (hasData != true) {
      List<QueryDocumentSnapshot> Data = fetchData.docs;
      for (int x = 0; x < Data.length; x++) {
        log('${Data[x].get('name')}');
        // newData.addAll(Data[x].get('notification'));
      }
    }
    emit(hasNotification(hasnotification: hasData));
  }
}
