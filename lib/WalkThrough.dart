import 'package:petrocardapppp/LoginPage.dart';
import 'package:petrocardapppp/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: WalkThrough(),
    );
  }
}

class WalkThrough extends StatelessWidget {

  const WalkThrough({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
            borderRadius: BorderRadius.circular(90.0),
            side: const BorderSide(color: AppColors.translightPurple,width: 2.5),
          ),
        ),
       finishButtonTextStyle: const TextStyle(
         color: Colors.white,
         fontSize: 16.0,
         fontWeight: FontWeight.w500,
       ),
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
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
      width:MediaQuery.of(context).size.width,
      height: height /2,
      child: Center(
        child: Lottie.asset('assets/images/animation_walkthrough.json',repeat: true,
            fit: BoxFit.cover),
      ),
    ),
    SizedBox(
      width:MediaQuery.of(context).size.width,
      height: height /2,
      child: Center(
        child: Lottie.asset('assets/images/Animation_location new.json',repeat: true,
            reverse: true,
            fit: BoxFit.cover),
      ),
    ),
         SizedBox(
           width:MediaQuery.of(context).size.width,
           height: height /2,
           child: Center(
              child: Lottie.asset('assets/images/history_new2.json',repeat: true,
      reverse: true,
                  fit: BoxFit.cover),
            ),
         ),
        ],
        speed: 5,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Tap and go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Elevate your experience with Petro Card.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Fueling up made simple',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Running low on fuel? We help you find the closest petrol stations in seconds',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Track every fill-up effortlessly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Monitor, manage, and optimize with our transaction records.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}