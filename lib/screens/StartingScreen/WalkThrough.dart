import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class WalkThrough extends StatelessWidget {
  const WalkThrough({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    double screenHeight = ScreenUtil().screenHeight;
    return SafeArea(
      child: OnBoardingSlider(
        finishButtonText: 'Login',
        hasFloatingButton: true,
        onFinish: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: AppColors.darkPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0.r),
          ),
        ),
       finishButtonTextStyle: TextStyle(
         color: Colors.white,
         fontSize: 14.0.sp,
         fontWeight: FontWeight.w500,
       ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.darkPurple,
            fontWeight: FontWeight.w600,
          ),
        ),

  controllerColor: AppColors.darkPurple,
  totalPage: 3,
  headerBackgroundColor: Colors.white,
  pageBackgroundColor: Colors.white,
  background: [
    SizedBox(
      width: screenWidth,
      height: 400.h,
      child: Center(
        child: Lottie.asset('assets/Animations/animation_walkthrough.json',repeat: true,
            fit: BoxFit.cover),
      ),
    ),
    SizedBox(
      width: screenWidth,
      height: 400.h,
      child: Center(
        child: Lottie.asset('assets/Animations/Animation_location new.json',repeat: true,
            reverse: true,
            fit: BoxFit.cover),
      ),
    ),
         SizedBox(
           width: screenWidth,
           height: 400.h,
           child: Center(
              child: Lottie.asset('assets/Animations/history_new2.json',repeat: true,
               reverse: true,
               fit: BoxFit.cover),
            ),
         ),
        ],
        speed: 5,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 400.h,
                ),
                Text(
                  'Tap and go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height:20.h,
                ),
                Text(
                  'Elevate your experience with Petro Card.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 400.h,
                ),
                Text(
                  'Fueling up made simple',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Running low on fuel? We help you find the closest petrol stations in seconds',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 400.h,
                ),
                Text(
                  'Track every fill-up effortlessly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Monitor, manage, and optimize with our transaction records.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}