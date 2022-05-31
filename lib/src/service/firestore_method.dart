import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tour_application/src/global/global.dart';
import 'package:tour_application/src/view/privacy/privacy_policy.dart';
import 'package:tour_application/src/widget/show_msg.dart';

import '../routes/routes.dart';

class FirestoreMethod with ChangeNotifier {
  final box = GetStorage();
  bool isLoading = false;

  sendUserData({
    required String name,
    required String phone,
    required String address,
    required String dob,
    required String gender,
  }) {
    if (name.isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Please type your name");
      return;
    } else if (phone.isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Please type your  phone number");
      return;
    } else if (address.isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Please type your address");

      return;
    } else if (dob.isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Please select your date of birth");
      return;
    } else if (gender.isEmpty) {
      isLoading = false;
      notifyListeners();
      showMessage("Please select gender");

      return;
    } else {
      isLoading = true;
      notifyListeners();
      try {
        CollectionReference _course =
            FirebaseFirestore.instance.collection("users-form-data");
        _course.doc(firebaseAuth.currentUser!.email).set({
          "name": name,
          "phone": phone,
          "address": address,
          "dob": dob,
          "gender": gender.trim()
        }).whenComplete(() {
          isLoading = false;
          notifyListeners();
          box.write('name', name);
          box.write('phone', phone);
          box.write('address', address);
          box.write('dob', dob);
          box.write('gender', gender);
          showMessage("Added Successfully");
          Get.toNamed(privacyPolicy);
        });
      } catch (e) {
        isLoading = false;
        notifyListeners();
        showMessage(e.toString());
      }
    }
  }
}
