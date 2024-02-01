import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Pages/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/Components/CustomTextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  bool showPasswordFields = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        child: Column(
            children: <Widget>[
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  height: height * 0.25,
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.translightPurple2,
                        AppColors.neutralBackground,
                      ],
                    ),
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
                            child: const Text(
                              "Reset password",
                              style: TextStyle(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1400),
                            child: const Text(
                              "Change your password",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
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
                    decoration: const BoxDecoration(
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
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 30.0),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                             child: CustomPassfields(icon: Icons.lock_outline_rounded,icon2:Icons.lock_person_outlined,controller: newPasswordController,controller2: confirmPasswordController,hintText: 'New Password',hintText2: 'Confirm Password',obscureText: !showPasswordFields,),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 2100),
                            child: GestureDetector(
                              onTap: () {
                                changePassword();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
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
                                height: 40,
                                width: width * .7,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child:
                                  Text(
                                    "Confirm",
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
                          const SizedBox(height: 20),
                      ],
                    ),
                  ),
              ),
                ),
              ),
    ]
              ),
    ),


        );
  }

  void changePassword() {
    // String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Implement your change password logic here

    // Example: Check if the passwords match and meet certain criteria
    if (
    // oldPassword.isEmpty||
    newPassword.isEmpty || confirmPassword.isEmpty) {
      showSnackBar('Please fill in all fields.', isError: true);
    } else if (newPassword != confirmPassword) {
      showSnackBar('New password and confirm password do not match.', isError: true);
    } else if (newPassword.length < 8) {
      showSnackBar('Password should be at least 8 characters long.', isError: true);
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

  void showSnackBar(String message,{required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }
}
