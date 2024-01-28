import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:petrocardapppp/Forgot Password/otpVerify.dart';
import 'package:petrocardapppp/Components/colors.dart';

class CheckNumber extends StatefulWidget {
  final String? initialMobileNumber;
  const CheckNumber({super.key, this.initialMobileNumber});

  @override
  State<CheckNumber> createState() => _CheckNumberdState();
}

class _CheckNumberdState extends State<CheckNumber> {
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
        backgroundColor: isError ? AppColors.red : Colors.green,
      ),
    );
  }
}
