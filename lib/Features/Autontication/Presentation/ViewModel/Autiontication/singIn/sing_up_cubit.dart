import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sing_up_state.dart';

class SingUpCubit extends Cubit<SingUpState> {
  SingUpCubit() : super(SingUpInitial());
  singUp(
      String email, String Password, String fristName, String lastName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      print('Successfully signed up: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.code}');
      }
    } catch (e) {
      print(e);
    }
  }
}
