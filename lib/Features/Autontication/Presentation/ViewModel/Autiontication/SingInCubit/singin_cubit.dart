import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'singin_state.dart';

class SinginCubit extends Cubit<SinginState> {
  SinginCubit() : super(SinginInitial());

  sigin(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Successfully signed in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        print('Invalid credential. Please check your email and password.');
      } else if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Error: ${e.code}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  changeState(int index) {
    log('$index');
    emit(ChangeLoginState(index: index));
  }

  visable(isVisable) {
    emit(ChangeVisability(isVisable: !isVisable));
  }

  slider() {
    emit(ChangeSlider(offset: true));
    log('message');
  }
}
