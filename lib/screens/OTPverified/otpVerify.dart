import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final String initialMobileNumber;

  const OtpPage({Key? key, required this.initialMobileNumber})
      : super(key: key);

  @override
  State<OtpPage> createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();
  bool isLoading = false;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  Future<void> _checkOtp() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final String apiUrl =
        'https://petrocard.000webhostapp.com/API/checkotp.php'; // Replace with your API URL
    String OTP =
        '${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}${otpController5.text}${otpController6.text}';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email': setpreference.getString('email'),
          'otp': OTP},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          isLoading = false;
        });
        if (responseData['success'] == true) {
          print('$responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
          print(responseData['message']);
        } else {
          print(responseData['message']);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      } else {
        // Handle API error
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            child: Stack(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 25.0.h,
                        bottom: 15.h,
                      ),
                      height: 0.30.sh,
                      width: width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.0.h),
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 450),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInDown(
                                duration: const Duration(milliseconds: 460),
                                child: Text(
                                  "OTP",
                                  style: TextStyle(
                                    color: AppColors.darkPurple,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "RobotoMono",
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FadeInDown(
                                duration: const Duration(milliseconds: 470),
                                child: Text(
                                  "Enter your 6 -Digit OTP to verify",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  duration: Duration(milliseconds: 2000),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0.r),
                            topRight: Radius.circular(50.0.r),
                          ),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.black,
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 10.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0.h,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 520),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildOtpTextField(otpController1, focusNode1,
                                      null, focusNode2),
                                  buildOtpTextField(otpController2, focusNode2,
                                      focusNode1, focusNode3),
                                  buildOtpTextField(otpController3, focusNode3,
                                      focusNode2, focusNode4),
                                  buildOtpTextField(otpController4, focusNode4,
                                      focusNode3, focusNode5),
                                  buildOtpTextField(otpController5, focusNode5,
                                      focusNode4, focusNode6),
                                  buildOtpTextField(otpController6, focusNode6,
                                      focusNode5, null),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _checkOtp();
                                },
                                child: Center(
                                  child: Container(
                                    height: 36.h,
                                    width: 0.7.sw,
                                    decoration: BoxDecoration(
                                      color: AppColors.darkPurple,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: isLoading
                ? Container(
                    color: AppColors.white.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.halfTriangleDot(
                          color: AppColors.darkPurple, size: 50),
                    ))
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildOtpTextField(
    TextEditingController controller,
    FocusNode currentFocusNode,
    FocusNode? previousFocusNode,
    FocusNode? nextFocusNode,
  ) {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        focusNode: currentFocusNode,
        onChanged: (value) {
          if (value.isEmpty && previousFocusNode != null) {
            previousFocusNode.requestFocus();
          } else if (value.isNotEmpty && nextFocusNode != null) {
            currentFocusNode.unfocus();
            nextFocusNode.requestFocus();
          }
        },
        decoration: const InputDecoration(
          counter: Offstage(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkPurple),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
