import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tour_application/src/app/app_color.dart';
import 'package:tour_application/src/widget/custom_button.dart';

class PrivacyPolicy extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  RxBool _loaded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 3.w,
            right: 3.w,
            top: 2.h,
          ),
          child: Column(
            children: [
              Expanded(
                  child: SfPdfViewer.network(
                "https://firebasestorage.googleapis.com/v0/b/shelter-b9151.appspot.com/o/privacy%20policy%2Fprivacy-policy.pdf?alt=media&token=98e4c1b0-c75c-4c2c-9403-326eca08f86c",
                onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                  _loaded.value = true;
                },
              )),
              Obx(() => _loaded == true
                  ? CustomButton(onTap: () {}, title: "Agree")
                  : Text("Still Loading")),
              SizedBox(
                height: 1.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
