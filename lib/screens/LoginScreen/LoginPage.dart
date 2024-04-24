import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/FpassScreens/PhoneCheck.dart';
import 'package:petrocardapppp/screens/MainScreens/BaseScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:petrocardapppp/screens/LoginScreen/Signup.dart';
import 'package:petrocardapppp/utilities/colors.dart';

import '../Admin side/Components/Base_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool showPassword = true;
  bool isLoading = false;
  String? role;

  Future<void> handleLogin() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final apiUrl = 'https://petrocard.000webhostapp.com/API/login.php';
      try {
        setState(() {
          isLoading = true;
        });
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            "email": emailController.text,
            "password": passwordController.text,
          },
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final data = jsonDecode(response.body)['user'];
          setpreference.setString('id', data['id'].toString());
          setpreference.setString('name', data['name'].toString());
          setpreference.setString('phone', data['phone'].toString());
          setpreference.setString('email', data['email'].toString());
          setpreference.setString('timestamp', data['timestamp'].toString());
          setpreference.setString('role', data['role'].toString());
          role = data['role'].toString();
          setState(() {
            isLoading = false;
          });
          if (!responseData['error']) {
            if (role == '1') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => BaseScreen()),
                  (Route<dynamic> route) => false);
            } else if (role == '0') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => AdminDashboard()),
                  (Route<dynamic> route) => false);
            }
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
        }
      } catch (error) {
        print('Error calling API: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid User and Password'),
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
                key: formKey,
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
                                      "Login",
                                      style: TextStyle(
                                        color: AppColors.darkPurple,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "RobotoMono",
                                        fontSize: 30.sp,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  FadeInDown(
                                    duration: const Duration(milliseconds: 470),
                                    child: Text(
                                      "Hey there,",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  FadeInDown(
                                    duration: const Duration(milliseconds: 480),
                                    child: Text(
                                      "Welcome Back",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                  color: AppColors.darkPurple,
                                  blurRadius: 10,
                                  offset: Offset(4, 4),
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: AppColors.white,
                                        border: Border.all(color: AppColors.lightPurple),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: AppColors.lightPurple,
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          )
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        CustomTextfield(
                                          icon: Icons.mail_outline,
                                          validatorValue: (val) {
                                            if (RegExp(r"\s").hasMatch(val!)) {
                                              return "Invalid email";
                                            } else {
                                              if (RegExp(r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                                  .hasMatch(val)) {}
                                            }
                                            return null;
                                          },
                                          errorMsg: 'Enter Valid Email',
                                          hintText: 'Email',
                                          controller: emailController,
                                        ),
                                        CustomPassfields(
                                          icon: Icons.lock_outline,
                                          icon2: Icons.lock_outline,
                                          hintText: 'Password',
                                          hintText2: 'Password',
                                          controller: passwordController,
                                          validator: (val) {
                                            return null;
                                          },
                                          errorMsg: 'Enter password',
                                          controller2: passwordController,
                                          obscureText: showPassword,
                                          oneField: true,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0.h,
                                ),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 550),
                                    child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                       NumberCheck(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                  color: AppColors.darkPurple,
                                                  fontSize: 13.0.sp,
                                                  letterSpacing: 0.7),
                                            )))),
                                const SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                  duration: const Duration(milliseconds: 600),
                                  child: GestureDetector(
                                    onTap: () {
                                      handleLogin();
                                      FocusScope.of(context).unfocus();
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
                                            "Login",
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
                                FadeInUp(
                                    duration: const Duration(milliseconds: 630),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const SignUppage(),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Not a member? ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .secondaryText,
                                                        letterSpacing: 0.5,
                                                        fontSize: 14.0.sp)),
                                                Text("Create Account",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .darkPurple,
                                                        letterSpacing: 0.5,
                                                        fontSize: 14.0.sp)),
                                              ],
                                            ))))
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
