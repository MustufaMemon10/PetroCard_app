import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/MainScreens/BaseScreen.dart';
import 'package:petrocardapppp/screens/Profile_screen/Update_profile_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool showPasswordFields = false;
  bool isLoading = false;

  Future<void> changePassword() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();

    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final changePasswordUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/changepassword.php");
      final response = await http.post(changePasswordUrl, body: {
        "id": setpreference.getString('id'),
        "password": oldPasswordController.text,
        "newpassword": passwordController.text,
      });
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
        });
        if (!responseData['error']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password changed successfully"),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BaseScreen()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error changing password"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Customize background color
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.angleLeft, color: AppColors.black),
          ),
          title: Text(
            'Reset password',
            style: TextStyle(color: AppColors.darkPurple, fontSize: 22.0),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 1.sh,
              child: Column(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 520),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.h, vertical: 10.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              'Keep your Account safe with a new password.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkPurple,
                                  fontFamily: 'RobotoMono'),
                            ),
                          ),
                          SizedBox(height: 30.0.h),
                          FadeInUp(
                            duration: const Duration(milliseconds: 570),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: oldPasswordController,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (oldPasswordController.text.length < 8) {
                                      if (value!.isEmpty) {
                                        return 'old password is required';
                                      }
                                      return 'Enter 8 Character Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'old password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightPurple),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkPurple),
                                      // Customize focused border color
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.red),
                                      // Customize error border color
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintStyle: const TextStyle(
                                        color: AppColors.secondaryText,
                                        letterSpacing: 0.7),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 20.0),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: AppColors.darkPurple,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  textInputAction: TextInputAction.next,
                                  obscureText: !showPasswordFields,
                                  validator: (value) {
                                    if (passwordController.text.length < 8) {
                                      if (value!.isEmpty) {
                                        return 'New password is required';
                                      }
                                      return 'Enter 8 Character Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'New password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightPurple),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkPurple),
                                      // Customize focused border color
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.red),
                                      // Customize error border color
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintStyle: const TextStyle(
                                        color: AppColors.secondaryText,
                                        letterSpacing: 0.7),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 20.0),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.userLock,
                                      color: AppColors.darkPurple,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: confirmPasswordController,
                                  textInputAction: TextInputAction.next,
                                  obscureText: !showPasswordFields,
                                  validator: (value) {
                                    if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      if (value!.isEmpty) {
                                        return 'Confirm password is required';
                                      }
                                    }
                                    return "Password doesn't match";
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Confirm password',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightPurple),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkPurple),
                                        // Customize focused border color
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.red),
                                        // Customize error border color
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      hintStyle: const TextStyle(
                                          color: AppColors.secondaryText,
                                          letterSpacing: 0.7),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.userLock,
                                        color: AppColors.darkPurple,
                                        size: 18.0,
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
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0.h,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 620),
                            child: SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  changePassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkPurple,
                                  elevation: 2,
                                  side: BorderSide(
                                      width: 0.8, color: AppColors.black),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: AppColors.lightPurple)),
                                ),
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
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
              ]),
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
    ]);
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

class PasstextField extends StatefulWidget {
  final TextEditingController Controller;
  final IconData prefixicon;
  final Function(String value) validatorValue;
  final bool address;
  final String errorMsg;
  final bool obscureText;
  final bool issufix;
  final String hintText;

  const PasstextField({
    Key? key,
    required this.Controller,
    required this.prefixicon,
    required this.validatorValue,
    required this.errorMsg,
    this.issufix = false,
    required this.obscureText,
    this.address = false,
    required this.hintText,
  }) : super(key: key);

  State<PasstextField> createState() => _PasstextFieldState();
}

class _PasstextFieldState extends State<PasstextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.Controller,
      textInputAction: TextInputAction.next,
      obscureText: _isObscured,
      validator: (value) {
        widget.validatorValue(value!);
        if (value.isEmpty) {
          return widget.errorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkPurple),
            // Customize focused border color
            borderRadius: BorderRadius.circular(20.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
            // Customize error border color
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintStyle: const TextStyle(
              color: AppColors.secondaryText, letterSpacing: 0.7),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          prefixIcon: widget.address
              ? Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Icon(
                    widget.prefixicon,
                    color: AppColors.darkPurple,
                    size: 18.0,
                  ),
                )
              : Icon(
                  widget.prefixicon,
                  color: AppColors.darkPurple,
                  size: 18.0,
                ),
          suffixIcon: widget.issufix
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.darkPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null),
    );
  }
}
