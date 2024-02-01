import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';

String generateGreeting() {
  var hour = DateTime.now().hour;

  if (hour < 12) {
    return "Good morning,";
  } else if (hour < 17) {
    return "Good afternoon,";
  } else {
    return "Good evening,";
  }
}

class GreetingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
      generateGreeting(),
      style: TextStyle(fontSize: 18.0.sp,fontWeight: FontWeight.w600,color: AppColors.primaryText),
    );
  }
}

