import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:petrocardapppp/screens/Forgot Passwordscreen/Check Number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/screens/Forgot Passwordscreen/ChangePasswordScreen.dart';

class OtpPage extends StatefulWidget {
  final String initialMobileNumber;

  const OtpPage({Key?key, required this.initialMobileNumber})  : super(key: key);

  @override
  State<OtpPage> createState() => OtpPageState();

}

class OtpPageState extends State<OtpPage> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            FadeInDown(
              duration:  const Duration(milliseconds: 1000),
              child: Container(
                width: width,
                decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.translightPurple2,
                          AppColors.neutralBackground,
                        ])),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 30.h),
                  child: FadeInUp(
                    duration:  const Duration(milliseconds: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration:  const Duration(milliseconds: 1000),
                          child:  Text(
                            "OTP",
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
                          duration:  const Duration(milliseconds: 1000),
                          child:  Text(
                            "Verify!",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        FadeInUp(
                          duration:  const Duration(milliseconds: 1300),
                          child:  Text(
                            "Please verify your Mobile number by entering 4-digit Otp",
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
                          duration:  const Duration(milliseconds: 1400),
                          child: Row(
                            children: [
                              Text(
                                style:  TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                                '+91${widget.initialMobileNumber}',
                              ),
                              TextButton(onPressed: () {
                                String mobileNumber = widget.initialMobileNumber;
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => CheckNumber(initialMobileNumber: mobileNumber),
                                  ),
                                );
                              },
                                child:  Text("Edit",
                                  style: TextStyle(
                                    color: AppColors.translightPurple,
                                    fontSize: 14.sp
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FadeInUp(
                duration:  const Duration(milliseconds: 1700),
                child: Container(
                  decoration:  BoxDecoration(
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
                    padding:  EdgeInsets.symmetric(
                        horizontal: 40.w, vertical: 10.0.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0.h,
                          ),
                          FadeInUp(
                            duration:  const Duration(milliseconds: 1900),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:  EdgeInsets.all(10.0.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      buildOtpTextField(
                                          otpController1, focusNode1, null,
                                          focusNode2),
                                      buildOtpTextField(
                                          otpController2, focusNode2,
                                          focusNode1, focusNode3),
                                      buildOtpTextField(
                                          otpController3, focusNode3,
                                          focusNode2, focusNode4),
                                      buildOtpTextField(
                                          otpController4, focusNode4,
                                          focusNode3, null),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          FadeInUp(
                            duration:  const Duration(milliseconds: 2000),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 20.0.w, vertical: 30.0.h),
                              child: GestureDetector(
                                onTap: () {
                                  verifyOtp();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0.r),
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
                                  height: 40.h,
                                  width: .7.sw,
                                  child:  Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Verify",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        letterSpacing: 1.0,
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
    );
  }

  Widget buildOtpTextField(TextEditingController controller,
      FocusNode currentFocusNode,
      FocusNode? previousFocusNode,
      FocusNode? nextFocusNode,) {
    return SizedBox(
        width: 50.w,
        child: TextField(
          controller: controller,
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          focusNode: currentFocusNode,
          onChanged: (value) {
            if (value.isEmpty && previousFocusNode != null) {
              previousFocusNode.requestFocus();
            }
            else if (value.isNotEmpty && nextFocusNode != null) {
              currentFocusNode.unfocus();
              nextFocusNode.requestFocus();
            }
          },
          decoration: const InputDecoration(
            counter: Offstage(),
            border: OutlineInputBorder(),
          ),
        )
    );
  }
  Future<void> verifyOtp() async  {
    String otp = "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
    // Check if the entered OTP is correct
    if (otp == '1234') {
      showSnackBar('OTP is Correct!', isError: false);
      // Navigate to the next screen after showing success message
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        ),
      );
    } else {
      showSnackBar('Invalid OTP. Please try again.', isError: true);
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
