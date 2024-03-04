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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/Animations/applied successfully animation.json',repeat: true,),
            ),
            SizedBox(height: 20.0,),
            Text("Request is Successfully Applied",style: TextStyle(fontSize: 18.0.sp,color: AppColors.primaryText,fontWeight: FontWeight.w600),),
            SizedBox(height: 10.0,),
            Text('We will inform you when your request is accepted',style: TextStyle(fontSize: 14.0.sp,color: AppColors.secondaryText,fontWeight: FontWeight.w400)),
          ],
        ),
              SizedBox(height: 70,),
              Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkPurple,
                  ),
                  child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (BuildContext context) => BaseScreen()), (
                        Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ),
                  ),
                  SizedBox(height: 5.0,),
                  Text('Go back',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),)
                ],
              ),
              ),
      ],

    );

  }
}
