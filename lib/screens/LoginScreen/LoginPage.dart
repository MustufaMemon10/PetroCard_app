import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:petrocardapppp/screens//Forgot Passwordscreen/Check Number.dart';
import 'package:petrocardapppp/screens/LoginScreen/Signup.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;

  void showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }

  void handleLogin() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      showSnackBar('Please fill both username and password.', isError: true);
    } else {
      bool authenticationSuccess = authenticateUser(username, password);
      if (authenticationSuccess) {
        showSnackBarAndNavigate('Login Successful', isError: false);
      } else {
        showSnackBar('Username & password are Incorrect', isError: true);
      }
    }
  }

  void showSnackBarAndNavigate(String message, {required bool isError}) {
    showSnackBar(message, isError: isError);
    //home page after successful msg
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const BaseScreen()),
      );
    });
  }

  bool authenticateUser(String username, String password) {
    return username == "Mustufa Memon" && password == "jerry123";
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
        child: isLoading?Center(child:CircularProgressIndicator(color: AppColors.black,)) :SizedBox(
          height: height,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    height: 230.h,
                    width: width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.translightPurple2,
                            AppColors.neutralBackground,
                          ]),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 10.0.h),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.sp,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: Text(
                                "Hey there,",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1400),
                              child: Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                ),
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
                            topLeft: Radius.circular(50.0.r),
                            topRight: Radius.circular(50.0.r),
                          ),
                          color: AppColors.white,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0.h,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.white,
                                    border:
                                    Border.all(color: AppColors.lightPurple),
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
                                      obscureText: false,
                                      validatorValue: (val) {
                                        if (val.isEmpty ||
                                            RegExp(r"\s").hasMatch(val)) {
                                          return "Email must not be empty";
                                        } else {
                                          if (RegExp(
                                              r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                              .hasMatch(val)) {
                                          }
                                        }
                                      },
                                      errorMsg: 'Enter Valid Email',
                                      hintText: 'Username or email',
                                      controller: usernameController,
                                    ),
                                    CustomTextfield(
                                      icon: Icons.lock_outline,
                                      hintText: 'Password',
                                      validatorValue: (val) {
                                        if (val.isEmpty ||
                                            RegExp(r"\s").hasMatch(val)) {
                                        }
                                      },
                                      errorMsg: 'Use Proper Password',
                                      obscureText: showPassword,
                                      controller: passwordController,
                                      showBorder: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 2100),
                                child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => const CheckNumber(
                                                initialMobileNumber: null,
                                              ),
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
                              duration: const Duration(milliseconds: 2100),
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
                                      borderRadius: BorderRadius.circular(50.r),
                                      boxShadow: (const [
                                        BoxShadow(
                                          color: AppColors.darkPurple,
                                          blurRadius: 5,
                                          offset: Offset(5, 5),
                                          blurStyle: BlurStyle.normal,
                                        ),
                                      ]),
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
                                duration: const Duration(milliseconds: 2200),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => const SignUppage(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text("Not a member? ",
                                                style: TextStyle(
                                                    color:
                                                    AppColors.secondaryText,
                                                    letterSpacing: 0.5,
                                                    fontSize: 14.0.sp)),
                                            Text("Create Account",
                                                style: TextStyle(
                                                    color: AppColors.darkPurple,
                                                    letterSpacing: 0.5,
                                                    fontSize: 14.0.sp)),
                                          ],
                                        )))),
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
      ),
    );
  }
}
