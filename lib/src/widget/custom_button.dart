import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../app/app_color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  CustomButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 6.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColor.btnColor),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Colors.white),
        ),
      ),
    );
  }
}
