import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_application/src/app/app_color.dart';
import 'package:tour_application/src/app/app_image.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:tour_application/src/widget/untils.dart';

class OnBoardingPage extends StatelessWidget {
  // ignore: prefer_final_fields, unused_field
  RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Container(
                child: Lottie.asset(lottieFiles[_currentIndex.toInt()],
                    height: 30.h, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.backColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 10,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 5,
                            spreadRadius: 1.0)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            "${slidetitle[_currentIndex.toInt()]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16.sp),
                          ),
                        ),
                        Obx(
                          () => Text("${description[_currentIndex.toInt()]}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => DotsIndicator(
                                dotsCount: lottieFiles.length,
                                position: _currentIndex.toDouble(),
                                decorator: DotsDecorator(),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_currentIndex == slidetitle.length - 1) {
                                  Get.toNamed(signupScreen);
                                } else {
                                  _currentIndex + 1;
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(4.0, 4.0),
                                          blurRadius: 10,
                                          spreadRadius: 1.0),
                                      BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-4.0, -4.0),
                                          blurRadius: 5,
                                          spreadRadius: 1.0)
                                    ]),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 5.w,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
