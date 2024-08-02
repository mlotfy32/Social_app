import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Constants {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  dynamic userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('notification');
  CollectionReference usersPosts =
      FirebaseFirestore.instance.collection('userPosts');
  CollectionReference search = FirebaseFirestore.instance.collection('search');
  CollectionReference Stores = FirebaseFirestore.instance.collection('Stores');

  /*
                         static   CollectionReference usersCollection =
                      FirebaseFirestore.instance.collection('users');
                      */
}
