import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tour_application/src/app/app_color.dart';

import 'package:tour_application/src/app/app_image.dart';
import 'package:tour_application/src/global/global.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  Future chooseScreen() async {
    var userId = box.read('uid');
    var email = box.read('email');
    var pass = box.read('password');
    var name = box.read('name');
    var phone = box.read('phone');
    var address = box.read('address');
    var gender = box.read('gender');
    var age = box.read('age');
    print(userId);
    if (email == null) {
      Get.toNamed(signupScreen);
    } else if (pass == null) {
      Get.toNamed(signupScreen);
    } else if (name == null &&
        phone == null &&
        address == null &&
        gender == null &&
        age == null) {
      Get.toNamed(userFormScreen);
    } else if (userId == null) {
      Get.toNamed(onBording);
    } else {
      Get.toNamed(bottomNavController);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () => chooseScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.logo,
            ),
            Text(
              "SR Travel Agency",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}
