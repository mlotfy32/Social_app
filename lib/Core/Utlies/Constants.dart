import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Constants {
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  static dynamic userId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('notification');

  /*
                        static   CollectionReference usersCollection =
                      FirebaseFirestore.instance.collection('users');  static   CollectionReference usersCollection =
                      FirebaseFirestore.instance.collection('users');
                      */
}
