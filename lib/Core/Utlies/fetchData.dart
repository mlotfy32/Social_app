import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/Core/Utlies/Constants.dart';
import 'package:social_app/main.dart';

// class GetData {
//   userData() async {
//     List<String> profile = [];
//     var email = emailPrfs!.getString('email');
//     QuerySnapshot Data =
//         await Constants().Profile.where('email', isEqualTo: '$email').get();
//     List<QueryDocumentSnapshot> snapShot = await Data.docs;
//     snapShot.forEach((value) {
//       profile.add(value.get('fristName'));
//       profile.add(value.get('lastName'));
//       profile.add(value.get('profilePic'));
//       profile.add(value.get('backPic'));
//     });
//     return profile;
//   }
// }
