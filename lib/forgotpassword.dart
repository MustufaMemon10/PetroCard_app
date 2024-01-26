import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/LoginPage.dart';
import 'package:petrocardapppp/colors.dart';

class Forgotpassword extends StatefulWidget {
  final String? initialMobileNumber;
  const Forgotpassword({super.key, this.initialMobileNumber});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController mobileNumberController = TextEditingController();
  @override
  void initState(){super.initState();
  if(widget.initialMobileNumber !=null){
    mobileNumberController.text = widget.initialMobileNumber!;
  }
  }


  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        child: Column(
          children: <Widget>[
            FadeInDown(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: height * 0.25,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.translightPurple2,
                          AppColors.neutralBackground,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Reset password",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: Text(
                            "Forgot Password ?That's okay.",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Text(
                            "Please provide your Mobile number to reset your password ",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
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
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                       ),
                                    child:Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Icon(
                                            Icons.phone,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: mobileNumberController,
                                            keyboardType:
                                            TextInputType.number,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Mobile Number",
                                                hintStyle: TextStyle(
                                                    color: AppColors.grey)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                              child: GestureDetector(
                                onTap: () {checkNumber();},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: AppColors.darkPurple,
                                    boxShadow: ([
                                      BoxShadow(
                                        color: AppColors.lightPurple,
                                        blurRadius: 5,
                                        offset: Offset(0, 10),
                                        blurStyle: BlurStyle.normal,
                                      ),
                                    ]),
                                  ),
                                  height: 40,
                                  width: width * .6,
                                  child:  Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: 0.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void checkNumber() {
    if (mobileNumberController.text.isNotEmpty) {
      String mobileNumber = mobileNumberController.text;
      if (mobileNumber.length == 10 && int.tryParse(mobileNumber) != null) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => otpPage(
              mobileNumber: mobileNumberController.text,
            ),
          ),
        );
      } else {
        showSnackBar('Please provide a valid 10-digit mobile number.', isError: true);
      }
    } else {
      // Show an error message if the mobile number is empty
      showSnackBar('Please provide a valid 10-digit mobile number.', isError: true);
    }
  }

  void showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.translightPurple2 : Colors.green,
      ),
    );
  }
}
class otpPage extends StatefulWidget {
  final String mobileNumber;

  const otpPage({super.key, required this.mobileNumber});

  @override
  State<otpPage> createState() => _otpPageState();

}

class _otpPageState extends State<otpPage> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Column(
          children: <Widget>[
            FadeInDown(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: height * .31,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.translightPurple2,
                          AppColors.neutralBackground,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical:20),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "OTP",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Verify!",
                            style: TextStyle(
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: Text(
                            "Please verify your Mobile number by entering 4-digit Otp",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Row(
                            children: [
                              Text(
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                '+91${widget.mobileNumber}',
                              ),
                              TextButton(onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (
                                        context) => const Forgotpassword(),
                                  ),
                                );
                              },
                                child: Text("Edit",
                                  style: TextStyle(
                                    color: AppColors.translightPurple2,
                                  ),
                                ),
                              )
                            ],
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
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      buildOtpTextField(
                                          otpController1, focusNode1, null,
                                          focusNode2),
                                      buildOtpTextField(
                                          otpController2, focusNode2,
                                          focusNode1, focusNode3),
                                      buildOtpTextField(
                                          otpController3, focusNode3,
                                          focusNode2, focusNode4),
                                      buildOtpTextField(
                                          otpController4, focusNode4,
                                          focusNode3, null),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              child: GestureDetector(
                                onTap: () {
                                  verifyOtp();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: AppColors.darkPurple,
                                    boxShadow: ([
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
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Verify",
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
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtpTextField(TextEditingController controller,
      FocusNode currentFocusNode,
      FocusNode? previousFocusNode,
      FocusNode? nextFocusNode,) {
    return Container(
        width: 50,
        child: TextField(
          controller: controller,
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          focusNode: currentFocusNode,
          onChanged: (value) {
            if (value.isEmpty && previousFocusNode != null) {
              previousFocusNode.requestFocus();
            }
            else if (value.isNotEmpty && nextFocusNode != null) {
              currentFocusNode.unfocus();
              nextFocusNode.requestFocus();
            }
          },
          decoration: InputDecoration(
            counter: Offstage(),
            border: OutlineInputBorder(),
          ),
        )
    );
  }
  void verifyOtp()  {
    String otp = "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
    // Check if the entered OTP is correct
    if (otp == '1234') {
      showSnackBar('OTP is Correct!', isError: false);
      // Navigate to the next screen after showing success message
      Future.delayed(Duration(seconds: 5));
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChangePasswordScreen(),
        ),
      );
    } else {
      showSnackBar('Invalid OTP. Please try again.', isError: true);
    }
  }

  void showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }

}


class ChangePasswordScreen extends StatefulWidget {
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
      body: Container(
        height: height,
        child: Column(
            children: <Widget>[
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  height: height * 0.25,
                  width: width,
                  decoration: BoxDecoration(
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              "Reset password",
                              style: TextStyle(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: Text(
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
                    decoration: BoxDecoration(
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
                          SizedBox(height: 30.0),
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
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.lightPurple,
                                          ))),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Icon(
                                            Icons.lock_open,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: newPasswordController,
                                            obscureText: !showPasswordFields,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'New Password',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Icon(
                                            Icons.lock_outline,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: confirmPasswordController,
                                            obscureText: !showPasswordFields,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Confirm Password',
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  showPasswordFields
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    showPasswordFields = !showPasswordFields;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
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
                                  boxShadow: ([
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
                                child: Align(
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
                          SizedBox(height: 20),
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
      Future.delayed(Duration(seconds: 2500), () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    }
  }

  void showSnackBar(String message,{required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }
}
