import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tour_application/src/app/app_color.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:tour_application/src/service/firestore_method.dart';

import '../../widget/custom_button.dart';
import '../../widget/textform.dart';

// ignore: must_be_immutable
class UserFormSection extends StatelessWidget {
  UserFormSection({Key? key}) : super(key: key);

  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();
  Rx<TextEditingController> _dob = TextEditingController().obs;
  RxBool _value = false.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  _selectDate(BuildContext context) async {
    final select = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1900),
        lastDate: DateTime(2200));

    if (select != null && select != selectedDate) {
      _dob.value.text = "${select.day}/${select.month}/${select.year}";
    }
  }

  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    FirestoreMethod firestoreMethod = Provider.of<FirestoreMethod>(context);
    return Scaffold(
      backgroundColor: AppColor.backColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tell Us More About You.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.btnColor,
                    fontSize: 20.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  "We will not share your information outside this application.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomTextFormField(
                hintText: "Full Name",
                controller: _fullName,
              ),
              CustomTextFormField(
                hintText: "Phone Number",
                controller: _phoneNumber,
              ),
              CustomTextFormField(
                hintText: "Address",
                controller: _address,
              ),

              Obx(
                () => TextFormField(
                  controller: _dob.value,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.calendar,
                            color: Colors.black,
                          )),
                      contentPadding: const EdgeInsets.all(8),
                      hintText: "Date Of Birth",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.sp)),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 5.h,
                child: ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 90.0,
                  fontSize: 16.0,
                  initialLabelIndex: 0,
                  activeBgColor: [AppColor.btnColor],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.grey[900],
                  totalSwitches: 2,
                  labels: [
                    'Male',
                    'Female',
                  ],
                  onToggle: (index) {
                    if (index == 0) {
                      gender = "Male";
                    } else {
                      gender = "Female";
                    }
                    print("$index");
                  },
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              // ignore: unrelated_type_equality_checks
              firestoreMethod.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      title: "Submit",
                      onTap: () {
                        firestoreMethod.sendUserData(
                            name: _fullName.text,
                            phone: _phoneNumber.text,
                            address: _address.text,
                            dob: _dob.value.text,
                            gender: gender);
                      },
                    ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
