import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class User_details extends StatefulWidget {
  const User_details({super.key});

  @override
  State<User_details> createState() => _User_detailsState();
}

class _User_detailsState extends State<User_details> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 33,
          backgroundColor: Colors.transparent,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.darkPurple.withOpacity(0.7),
            child: Image.asset(
              'assets/Icons/user.png',
              height: 40,
              width: 30,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Mustufa Memon',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          'mustufamemon@gmail.com',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
