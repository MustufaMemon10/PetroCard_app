import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilities/colors.dart';

class Cardfield extends StatefulWidget {
  final String userName;
  final String card_num;
  const Cardfield({
    required this.card_num,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  State<Cardfield> createState() => _CardfieldState();
}

class _CardfieldState extends State<Cardfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.250.sh,
      width: 380.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0.r),
        border: Border.all(
            width: 0.4, color: AppColors.white.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 7),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:  [
            AppColors.darkPurple.withOpacity(1),
            AppColors.darkPurple.withOpacity(0.3),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/Icons/card.png',
                height: 80,
                width: 80.0,
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 12.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/Icons/chip (2).png',
                  height: 35.0.h,
                  width: 50.0.h,
                  color: Colors.white70,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8.0.w),
                  child: Image.asset(
                    'assets/Icons/contactless.png',
                    height: 35.0.h,
                    color: AppColors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.card_num,
                  style: TextStyle(
                    fontSize: 19.0.sp,
                    color:AppColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                    letterSpacing: 0.9,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 19.0.sp,
                        color:
                        AppColors.grey.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.9,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
