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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          child: Column(
            children: <Widget>[
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  height: height / 3.5,
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
                                  onTap: () {
                                    // Validate the mobile number (you can add more validation as needed)
                                    if (mobileNumberController.text.isNotEmpty) {
                                      String mobileNumber = mobileNumberController.text;
                                      if(mobileNumber.length==10 && int.tryParse(mobileNumber) !=null) {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                otpPage(
                                                  mobileNumber: mobileNumberController
                                                      .text,
                                                ),
                                          ),
                                        );
                                      }
                                      else{
                                        showDialog(context: context, builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please provide a valid 10-digit mobile number.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                      }
                                    } else {
                                      // Show an error message if the mobile number is empty
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please provide a valid 10-digit mobile number.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                        colors: [
                                          AppColors.translightPurple,
                                          AppColors.lightPurple,
                                          AppColors.translightPurple,
                                        ]
                                      ),
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
                                    width: width/1.7,
                                    child:  Align(
                                      alignment: Alignment.center,
                                      child:
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.9,
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
      body:Container(
        height: height,
        child: Column(
          children: <Widget>[
            FadeInDown(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: height / 3.5,
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
                              TextButton(onPressed: (){Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const Forgotpassword(),
                                ),
                              );},
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
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildOtpTextField(otpController1,focusNode1,null,focusNode2),
                                      buildOtpTextField(otpController2,focusNode2,focusNode1,focusNode3),
                                      buildOtpTextField(otpController3,focusNode3,focusNode2,focusNode4),
                                      buildOtpTextField(otpController4,focusNode4,focusNode3,null),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                              child: GestureDetector(
                                onTap: (){verifyOtp();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          AppColors.translightPurple,
                                          AppColors.lightPurple,
                                          AppColors.translightPurple,
                                        ]
                                    ),
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
                                  width: width/1.7,
                                  child:  Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.9,
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
  Widget buildOtpTextField(TextEditingController controller, FocusNode currentFocusNode,
      FocusNode? previousFocusNode,
      FocusNode? nextFocusNode,){
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
  void verifyOtp(){
    String otp = "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
    //check
    if(otp == '1234'){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Success'),
          content: Text('OTP is Correct!'),
          actions: [
            TextButton(onPressed: (){Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    CreatePasswordScreen(),
              ),
            );}, child: Text('OK')),
          ],
        );
      }
      );
    }
    else{
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Error"),
          content: Text('Invalid OTP please try again.'),
          actions: [
            TextButton(onPressed: (){  Navigator.of(context).pop();}, child: Text('OK'))
          ],
        );
      });
    }
  }
}

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePassword,
              child: Text('Save Password'),
            ),
          ],
        ),
      ),
    );
  }

  void savePassword() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      showAlertDialog('Error', 'Please enter both password and confirm password.');
    } else if (password != confirmPassword) {
      showAlertDialog('Error', 'Passwords do not match. Please try again.');
    } else {
      // Save or process the new password
      showAlertDialog('Password Saved', 'Your password has been successfully saved.');
    }
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

