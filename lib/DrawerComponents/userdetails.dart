import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_details extends StatefulWidget {
  const User_details({super.key});

  @override
  State<User_details> createState() => _User_detailsState();
}

class _User_detailsState extends State<User_details> {
  String userName = '';
  String email = '';
  getUserName() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name')!;
      email = setpreference.getString('email')!;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.6, color: AppColors.black),
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () {},
            splashColor: AppColors.accentColor.withOpacity(0.2),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.white.withOpacity(0.7),
              child: UserIcon(),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          userName,
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
          email,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black.withOpacity(0.5),
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
