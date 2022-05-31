import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_application/src/app/app_color.dart';
import 'package:tour_application/src/app/app_image.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:tour_application/src/service/auth_service.dart';

import '../../widget/custom_button.dart';
import '../../widget/textform.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool _value = false.obs;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create\nNew Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.btnColor,
                    fontSize: 28.sp),
              ),
              Text(
                "Create your account and start your journey",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 12.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomTextFormField(
                hintText: "E-mail Address",
                controller: email,
              ),
              CustomTextFormField(
                hintText: "Enter Password",
                controller: password,
              ),
              SizedBox(
                height: 13.h,
              ),
              authProvider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      title: "Create Account",
                      onTap: () {
                        authProvider.userRegistration(
                            email: email, password: password, context: context);
                      },
                    ),
              SizedBox(
                height: 5.h,
              ),
              Align(alignment: Alignment.center, child: Text("--OR--")),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Image.asset(AppImage.google)),
                    IconButton(
                        onPressed: () {}, icon: Image.asset(AppImage.facebook))
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                        text: "Already an User? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                            color: Colors.black),
                        children: [
                      TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.btnColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(logInScreen);
                            }),
                    ])),
              )
            ],
          ),
        ),
      )),
    );
  }
}
