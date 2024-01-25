import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/LoginPage.dart';
import 'package:petrocardapppp/colors.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
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
                                      child:const Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.phone,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType:
                                              TextInputType.number,
                                              decoration: InputDecoration(
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
                                  onTap: (){
                                  Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                  builder: (context) => const otpPage(),
                                  ),
                                  );
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
      ),
    );
  }
}
class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
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
                                "(Mobile Number)",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(onPressed: (){},
                              child: Text("Edit",
                              style: TextStyle(
                                color: AppColors.lightPurple2,
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
                                    child:const Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Icon(
                                            Icons.phone,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            keyboardType:
                                            TextInputType.number,
                                            decoration: InputDecoration(
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
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
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
}

