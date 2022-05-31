import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:tour_application/src/global/global.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:tour_application/src/widget/custom_button.dart';

class BottomNavController extends StatelessWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Center(
            child: Text("Nav"),
          ),
          CustomButton(
              onTap: () async {
                await firebaseAuth.signOut();
                Get.toNamed(signupScreen);
              },
              title: "Log Out")
        ]));
  }
}
