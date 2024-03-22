import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/screens/OTPverified/otpVerify.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckNumber extends StatefulWidget {
  const CheckNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckNumber> createState() => _CheckNumberedState();
}

class _CheckNumberedState extends State<CheckNumber> {
  TextEditingController mobileNumberController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _otpProvide() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final apiUrl = 'https://petrocard.000webhostapp.com/API/otpset.php';
      try {
        setState(() {
          isLoading = true;
        });
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            "numbers": mobileNumberController.text,
            "email": setpreference.getString('email'),
          },
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setpreference.setString('numbers', responseData['numbers'].toString());
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OtpPage(initialMobileNumber: mobileNumberController.text)));
          if (responseData['success'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(responseData['message'].toString()),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseData['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
      catch (error) {
        print('Error calling API: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No connection'),
            shape: OutlineInputBorder(),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Customize background color
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              color: AppColors.white,
              height: height,
              child: Form(
                key: _formKey,
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
                                      "Phone Number",
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
                                      "Enter your phone number to verify",
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
                                  child: TextFormField(
                                    controller: mobileNumberController,
                                    keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      hintText: 'Phone Number',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: AppColors.darkPurple),
                                        // Customize focused border color
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          letterSpacing: 0.7),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 15.0),
                                          child: Text(
                                            '+91',
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontSize: 16.0,
                                            ),
                                          )),
                                    ),
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: Text("Is this the correct Number?",style: TextStyle(fontSize: 16.0),),
                                          content:
                                          Text('+91'+mobileNumberController.text),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(
                                                    false); // Return false when cancel is pressed
                                              },
                                              child: Text("Edit",style: TextStyle(color: AppColors.accentColor),),
                                            ),
                                            TextButton(
                                              onPressed: () async{
                                               _otpProvide();
                                              },
                                              child: Text("Yes",style: TextStyle(color: AppColors.accentColor),),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 36.h,
                                        width: 0.7.sw,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkPurple,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
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
            ),
          ],
        ),
      ),
    );
  }
}
