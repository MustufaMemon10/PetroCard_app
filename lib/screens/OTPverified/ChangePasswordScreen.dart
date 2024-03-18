import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/Widgets/CustomTextfieldWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  bool showPasswordFields = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: 1.sh,
          child: Column(children: <Widget>[
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                height: .25.sh,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.r),
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
                        SizedBox(height: 8.h),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Text(
                            "Change your password",
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
                    color: AppColors.neutralBackground,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.primaryText,
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.h, vertical: 10.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0.h),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.white,
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
                              children: [
                                CustomPassfields(
                                  icon: Icons.lock_outline_rounded,
                                  icon2: Icons.lock_outline_rounded,
                                  controller: passwordController,
                                  controller2: oldPasswordController,
                                  validator: (val) {
                                    return null;
                                  },
                                  errorMsg: "Please Enter Password",
                                  hintText: 'Password',
                                  hintText2: 'Old Password',
                                  obscureText: !showPasswordFields,
                                  isBorder: true,
                                  oneField: true,
                                  isSufixIcon: false,
                                ),
                                CustomPassfields(
                                  icon: Icons.lock_person_outlined,
                                  icon2: Icons.lock_person_outlined,
                                  controller: passwordController,
                                  controller2: confirmPasswordController,
                                  validator: (val) {
                                    if (passwordController.text.length > 8) {
                                      return 'Enter 8 Character Password';
                                    }
                                    if (passwordController.text !=
                                        confirmPasswordController.text)
                                      return "Password doesn't match";
                                    if (RegExp(r"\s").hasMatch(val) ||
                                        RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)')
                                            .hasMatch(val)) {
                                      return "Use Proper Password ";
                                    }
                                  },
                                  errorMsg: "Please Enter Password",
                                  hintText: 'New Password',
                                  hintText2: 'Confirm Password',
                                  obscureText: !showPasswordFields,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0.h,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2100),
                          child: GestureDetector(
                            onTap: () {
                              changePassword();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0.r),
                                color: AppColors.darkPurple,
                                boxShadow: (const [
                                  BoxShadow(
                                    color: AppColors.darkPurple,
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                    blurStyle: BlurStyle.normal,
                                  ),
                                ]),
                              ),
                              height: 30.h,
                              width: .6.sw,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void changePassword() {
    // String oldPassword = oldPasswordController.text;
    String newPassword = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Implement your change password logic here

    // Example: Check if the passwords match and meet certain criteria
    if (
        // oldPassword.isEmpty||
        newPassword.isEmpty || confirmPassword.isEmpty) {
      showSnackBar('Please fill in all fields.', isError: true);
    } else if (newPassword != confirmPassword) {
      showSnackBar('New password and confirm password do not match.',
          isError: true);
    } else if (newPassword.length < 8) {
      showSnackBar('Password should be at least 8 characters long.',
          isError: true);
    } else {
      // Show success message
      showSnackBar('Password changed successfully.', isError: false);
      Future.delayed(const Duration(seconds: 2500), () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      });
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
