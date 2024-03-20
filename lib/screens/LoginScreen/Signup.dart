import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../OTPverified/Check Number.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  var logindata;
  var data;
  final formKey = GlobalKey<FormState>();
  bool showPasswordFields = false;

  Future<void> _handleSingUp() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();

    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url =
          Uri.parse("https://petrocard.000webhostapp.com/API/signup.php");
      final response = await http.post(login_url, body: {
        "email": emailController.text,
        "password": passwordController.text,
        "name": fullNameController.text,
        "role": "1",
      });
      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = jsonDecode(response.body)['data'];
        setpreference.setString('email', logindata['email'].toString());
        print(logindata);
        setState(() {
          isLoading = false;
        });
        if (logindata['error'] == false) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CheckNumber()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: AppColors.scaffoldBackgroundColor,
              height: height,
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    FadeInDown(
                      duration: Duration(milliseconds: 400),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 20.0.h),
                        width: width,
                        height: 0.25.sh,
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 450),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInDown(
                                duration: Duration(milliseconds: 460),
                                child: Text(
                                  "Sign up",
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
                              FadeInDown(
                                duration: Duration(milliseconds: 470),
                                child: Text(
                                  "New here?",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              FadeInDown(
                                duration: Duration(milliseconds: 480),
                                child: Text(
                                  "Become a member",
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
                    Container(
                      height: height,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0.r),
                                topRight: Radius.circular(50.0.r),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.h,
                                ),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 520),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
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
                                        children: <Widget>[
                                          CustomTextfield(
                                            controller: fullNameController,
                                            validatorValue: (val) {
                                              return null;
                                            },
                                            errorMsg: 'Please enter Full Name',
                                            showBorder: true,
                                            hintText: 'Full name',
                                            icon: Icons.person,
                                          ),
                                          CustomTextfield(
                                            controller: emailController,
                                            showBorder: true,
                                            validatorValue: (val) {
                                              if (RegExp(r"\s")
                                                  .hasMatch(val!)) {
                                                return "Email must not be empty";
                                              } else {
                                                if (RegExp(
                                                        r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                                    .hasMatch(val)) {}
                                              }
                                              return null;
                                            },
                                            errorMsg: 'Enter a valid Email',
                                            hintText: 'Email',
                                            icon: Icons.mail_outline,
                                          ),
                                          CustomPassfields(
                                            icon: Icons.lock_outline_rounded,
                                            icon2: Icons.lock_person_outlined,
                                            controller: passwordController,
                                            controller2:
                                                confirmPasswordController,
                                            validator: (val) {
                                              if (RegExp(r"\s").hasMatch(val) ||
                                                  RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)')
                                                      .hasMatch(val)) {
                                                return "Use Proper Password ";
                                              }
                                            },
                                            errorMsg: "Please Enter Password",
                                            hintText: 'Password',
                                            hintText2: 'Confirm Password',
                                            obscureText: !showPasswordFields,
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 550),
                                    child: MaterialButton(
                                      onPressed: () {
                                        _handleSingUp();
                                        FocusScope.of(context).unfocus();
                                      },
                                      color:
                                          const Color.fromRGBO(49, 39, 79, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      child: const Center(
                                        child: Text(
                                          "Sign up",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 600),
                                    child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                              );
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Already have an account?",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      letterSpacing: 0.5,
                                                      fontSize: 13.0),
                                                ),
                                                Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          49, 39, 79, .6),
                                                      letterSpacing: 0.5,
                                                      fontSize: 15.0),
                                                ),
                                              ],
                                            )))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
      ]),
    );
  }
}
