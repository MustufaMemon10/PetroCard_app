import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:petrocardapppp/screens/Forgot Passwordscreen//otpVerify.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class CheckNumber extends StatefulWidget {
  const CheckNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckNumber> createState() => _CheckNumberedState();
}

class _CheckNumberedState extends State<CheckNumber> {
  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  height: .25.sh,
                  width: width,
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: Text(
                              "Reset password",
                              style: TextStyle(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: Text(
                              "Forgot Password ?That's okay.",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1400),
                            child: Text(
                              "Please provide your Mobile number to reset your password ",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: 230,
                left: 0,
                right: 0,
                duration: Duration(milliseconds: 2000),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 1700),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0.r),
                          topRight: Radius.circular(50.0.r),
                        ),
                        color: AppColors.neutralBackground,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.primaryText,
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 10.0.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 30.0.h,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.white,
                                    border: Border.all(
                                        color: AppColors.lightPurple),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.lightPurple,
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: NumericTextField(
                                  hintText: 'Phone Number',
                                  controller: mobileNumberController,
                                  showBorder: false,
                                ),
                              ),
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 2000),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 30.0),
                                child: GestureDetector(
                                  onTap: () {
                                    checkNumber();
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: .6.sw,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.0.r),
                                      color: AppColors.darkPurple,
                                      boxShadow: (const [
                                        BoxShadow(
                                          color: AppColors.lightPurple,
                                          blurRadius: 5,
                                          offset: Offset(0, 10),
                                          blurStyle: BlurStyle.normal,
                                        ),
                                      ]),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          letterSpacing: 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> checkNumber() async {
    if (mobileNumberController.text.isNotEmpty) {
      String mobileNumber = mobileNumberController.text;
      if (mobileNumber.length == 10 && int.tryParse(mobileNumber) != null) {
        await Future.delayed(Duration(seconds: 2));
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => OtpPage(
              initialMobileNumber: mobileNumberController.text,
            ),
          ),
        );
      } else {
        showSnackBar('Please provide a valid 10-digit mobile number.',
            isError: true);
      }
    } else {
      // Show an error message if the mobile number is empty
      showSnackBar('Please provide a valid 10-digit mobile number.',
          isError: true);
    }
  }

  void showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }
}
