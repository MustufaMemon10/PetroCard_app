import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:petrocardapppp/Forgot%20Password/Check%20Number.dart';
import 'package:petrocardapppp/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Forgot%20Password/ChangePasswordScreen.dart';

class otpPage extends StatefulWidget {
  final String mobileNumber;

  const otpPage({super.key, required this.mobileNumber});

  @override
  State<otpPage> createState() => _otpPageState();

}

class _otpPageState extends State<otpPage> {
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
      body: Container(
        height: height,
        child: Column(
          children: <Widget>[
            FadeInDown(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: height * .3,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.translightPurple2,
                          AppColors.neutralBackground,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical:20),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "OTP",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Verify!",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: Text(
                            "Please verify your Mobile number by entering 4-digit Otp",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Row(
                            children: [
                              Text(
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                '+91${widget.mobileNumber}',
                              ),
                              TextButton(onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (
                                        context) => const CheckNumber(),
                                  ),
                                );
                              },
                                child: Text("Edit",
                                  style: TextStyle(
                                    color: AppColors.translightPurple2,
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
                duration: const Duration(milliseconds: 1700),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      color: AppColors.neutralBackground,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryText,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                  ),
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
                            duration: const Duration(milliseconds: 2000),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              child: GestureDetector(
                                onTap: () {
                                  verifyOtp();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: AppColors.darkPurple,
                                    boxShadow: ([
                                      BoxShadow(
                                        color: AppColors.lightPurple,
                                        blurRadius: 5,
                                        offset: Offset(0, 10),
                                        blurStyle: BlurStyle.normal,
                                      ),
                                    ]),
                                  ),
                                  height: 40,
                                  width: width * .7,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Verify",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
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
    return Container(
        width: 50,
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
          decoration: InputDecoration(
            counter: Offstage(),
            border: OutlineInputBorder(),
          ),
        )
    );
  }
  void verifyOtp()  {
    String otp = "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
    // Check if the entered OTP is correct
    if (otp == '1234') {
      showSnackBar('OTP is Correct!', isError: false);
      // Navigate to the next screen after showing success message
      Future.delayed(Duration(seconds: 5));
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChangePasswordScreen(),
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
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }

}
