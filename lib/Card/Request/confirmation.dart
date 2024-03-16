import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class ConfirmationAnimation extends StatefulWidget {
  const ConfirmationAnimation({super.key});

  @override
  State<ConfirmationAnimation> createState() => _ConfirmationAnimationState();
}

class _ConfirmationAnimationState extends State<ConfirmationAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/Animations/applied successfully animation.json',
                repeat: false,reverse: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Request is Successfully Applied",
              style: TextStyle(
                  fontSize: 18.0.sp,
                  color: AppColors.primaryText,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:25.0),
              child: Text('We will inform you when your request is accepted',
                  style: TextStyle(
                      fontSize: 14.0.sp,
                      color: AppColors.secondaryText,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 70,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BaseScreen()),
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.lightPurple2.withOpacity(0.7),
                          elevation: 0,
                          side: BorderSide(width: 1, color: AppColors.black),
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16.0,
                          color: AppColors.black,
                        ),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Go back',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
