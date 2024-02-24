import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController NumberController = TextEditingController();

  bool showPasswordFields = false;

  void showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }
  void handleSignUp() {
    String fullName = fullNameController.text;
    String email = emailController.text;
    String password = createPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackBar('Please fill in all fields.', isError: true);
    } else if (password != confirmPassword) {
      showSnackBar('Password and Confirm Password do not match.',
          isError: true);
    } else {
      // Perform signup logic here
      bool signUpSuccess =
      signUpUser(fullName, email,password, confirmPassword);

      if (signUpSuccess) {
        showSnackBarAndNavigate('Signup Successful', isError: false);
      } else {
        showSnackBar('Signup failed. Please try again.', isError: true);
      }
    }
  }

  bool signUpUser(String fullName, String email, String password,
      String confirmPassword) {
    // Perform signup authentication logic here
    // For example, check if the email is not already registered
    // and then store the new user data

    // For simplicity, assume all signups are successful
    return true;
  }

  void showSnackBarAndNavigate(String message, {required bool isError}) {
    showSnackBar(message, isError: isError);
    // Navigate to the home page after successful signup
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const BaseScreen()),
      );
    });
  }
// Other methods remain the same...

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: height,
            child: Column(
              children: <Widget>[
                FadeInDown(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.w, vertical: 50.0.h),
                    width: width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.translightPurple2,
                              AppColors.neutralBackground,
                            ])),
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: Text(
                              "New here?",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: Text(
                              "Become a member",
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
                Expanded(
                  flex: 1,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1600),
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
                                duration: const Duration(milliseconds: 1700),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                        obscureText: false,
                                        controller: fullNameController,
                                        validatorValue: (val) {},
                                        errorMsg: 'Please enter First Name',
                                        showBorder: true,
                                        hintText: 'Full name',
                                        icon: Icons.person,
                                      ),
                                      CustomTextfield(
                                        obscureText: false,
                                        controller: emailController,
                                        showBorder: true,
                                        validatorValue: (val) {
                                          if (val.isEmpty ||
                                              RegExp(r"\s").hasMatch(val)) {
                                            return "Email must not be empty";
                                          } else {
                                            if (RegExp(
                                                r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                                .hasMatch(val)) {
                                              return null;
                                            }
                                          }
                                        },
                                        errorMsg: 'Enter a valid Email',
                                        hintText: 'Email',
                                        icon: Icons.mail_outline,
                                      ),
                                      CustomTextfield(
                                        obscureText: false,
                                        controller: NumberController,
                                        showBorder: true,
                                        validatorValue: (val) {
                                        },
                                        errorMsg: 'Please enter contact no',
                                        hintText: 'Phone Number',
                                        icon: Icons.mail_outline,
                                      ),
                                      CustomPassfields(
                                        icon: Icons.lock_outline_rounded,
                                        icon2: Icons.lock_person_outlined,
                                        controller: createPasswordController,
                                        controller2: confirmPasswordController,
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
                                duration: const Duration(milliseconds: 1900),
                                child: MaterialButton(
                                  onPressed: () {
                                    handleSignUp();
                                  },
                                  color: const Color.fromRGBO(49, 39, 79, 1),
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
                                duration: const Duration(milliseconds: 2000),
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
                                                  color:
                                                  AppColors.secondaryText,
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
    );
  }
}
