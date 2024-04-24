import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import '../../utilities/colors.dart';
import '../../utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool showPasswordFields = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _forgotPassword() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();

    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final changePasswordUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/forgotpassword.php");
      final response = await http.post(changePasswordUrl, body: {
        "email": setpreference.getString('email'),
        "password": passwordController.text,
      });
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
        });
        if (!responseData['error']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error reseting password"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Customize background color
          ),
        );
        setState(() {
          isLoading = false;
        });
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
                                  FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: Text(
                                      "Reset password",
                                      style: TextStyle(
                                        color: AppColors.darkPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    child: Text(
                                      "Create a strong and secure new password for your account.",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 0,
                      right: 0,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.0.h),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.lightPurple),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: passwordController,
                                          obscureText: !showPasswordFields,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'New password is required';
                                            }
                                            if (passwordController.text.length <
                                                8) {
                                              return 'Enter 8 Character Password';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_outline_rounded,
                                              color: AppColors.darkPurple,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 15.0, horizontal: 20.0),
                                            border: InputBorder.none,
                                            hintText: 'New password',
                                            hintStyle:
                                                AppStyles.Textfield_hintstyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: confirmPasswordController,
                                          obscureText: !showPasswordFields,
                                          textInputAction: TextInputAction.go,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Confirm password is required';
                                            }
                                            if (confirmPasswordController.text !=
                                                passwordController.text) {
                                              return "Password doesn't match";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_person_outlined,
                                              color: AppColors.darkPurple,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 15.0, horizontal: 20.0),
                                            border: InputBorder.none,
                                            hintText: 'Confirm password',
                                            hintStyle: const TextStyle(
                                              color: AppColors.secondaryText,
                                              letterSpacing: 0.7,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                !showPasswordFields
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: AppColors.darkPurple,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  showPasswordFields =
                                                      !showPasswordFields;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              FadeInUp(
                                duration:
                                const Duration(milliseconds: 600),
                                child: InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    _forgotPassword();
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }
}
