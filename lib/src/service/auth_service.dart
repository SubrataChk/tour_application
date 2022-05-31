import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tour_application/src/routes/routes.dart';

import '../global/global.dart';
import '../widget/show_msg.dart';

class AuthProvider with ChangeNotifier {
  final box = GetStorage();
  bool isLoading = false;
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(AuthProvider.pattern.toString());

  Future userRegistration(
      {required TextEditingController? email,
      required TextEditingController? password,
      required BuildContext context}) async {
    if (email!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Email is empty!");
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      isLoading = false;
      notifyListeners();
      showMessage("Please enter a valid email address");
      return;
    } else if (password!.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Password is empty");
      return;
    } else if (password.text.length <= 7) {
      isLoading = false;
      notifyListeners();
      showMessage("Password must be 8 character or number");
      return;
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final User? firebaseUser = (await firebaseAuth
                .createUserWithEmailAndPassword(
                    email: email.text.trim(), password: password.text.trim())
                .catchError((error) {
          showMessage("Error: " + error.toString());
        }))
            .user;

        if (firebaseUser != null) {
          //Save user Data

          isLoading = false;
          notifyListeners();
          box.write('uid', firebaseUser.uid);
          box.write('email', email);
          box.write('password', password);

          // ignore: use_build_context_synchronously
          Get.toNamed(userFormScreen);
        } else {
          //Error
          showMessage("Sign Up Failed");
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        notifyListeners();
        if (e.code == 'weak-password') {
          isLoading = false;
          notifyListeners();
          showMessage("The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          isLoading = false;
          notifyListeners();
          isLoading = false;
          notifyListeners();
          showMessage("The account already exists for that email.");
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        showMessage(e.toString());
      }
    }
  }

  Future userLogin(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext context}) async {
    if (email.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Email address is empty");
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      isLoading = false;
      notifyListeners();
      showMessage("Please enter a valid email address");
      return;
    } else if (password.text.trim().isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Password is empty");
      return;
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final User? firebaseUser =
            (await firebaseAuth.signInWithEmailAndPassword(
                    email: email.text.trim(), password: password.text.trim()))
                .user;

        if (firebaseUser != null) {
          showMessage("Login Successfully");

          isLoading = false;
          notifyListeners();

          Get.toNamed(bottomNavController);
        }
      } on FirebaseException catch (e) {
        isLoading = false;
        notifyListeners();
        if (e.code == 'user-not-found') {
          isLoading = false;
          notifyListeners();
          showMessage("No user found for that email.");
        } else if (e.code == 'wrong-password') {
          isLoading = false;
          notifyListeners();
          showMessage("Wrong password");
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        showMessage(e.toString());
      }
    }
  }
}
