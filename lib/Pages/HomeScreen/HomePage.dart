import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
      children: [
       Container(
         height: 120.h,
         width: width,
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
               AppColors.translightPurple2,
               AppColors.neutralBackground,
             ],
           ),
         ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Padding(
             padding: EdgeInsets.symmetric(vertical: 10.0.w,horizontal: 10.0.h),
             child: Container(
               padding: EdgeInsets.symmetric(vertical: 10.0.w,horizontal: 10.0.h),
               height: 50,
               width: 50,
               decoration: BoxDecoration(
                 color: AppColors.white.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(60.r),
                 border: Border.all(
                   color: Colors.white.withOpacity(0.3), // Adjust the border color for better visibility
                   width: 1.5,
                 ),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(16.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: Image.asset("assets/Icons/menu.png",height: 40.h,width: 40.w,),
          ),
             ),
           ),
             ),
           ),
           Padding(
             padding: EdgeInsets.symmetric(vertical: 10.0.w,horizontal: 10.0.h),
             child: Container(
               padding: EdgeInsets.symmetric(vertical: 10.0.w,horizontal: 10.0.h),
               height: 50,
               width: 50,
               decoration: BoxDecoration(
                 color: AppColors.white.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(60.r),
                 border: Border.all(
                   color: Colors.white.withOpacity(0.3), // Adjust the border color for better visibility
                   width: 1.5,
                 ),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(16.0),
             child: BackdropFilter(
               filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
               child: Container(
                 color: Colors.white.withOpacity(0.1),
                 child: Image.asset("assets/Icons/notification-bell.png",height: 40.h,width: 40.w,),
               ),
             ),
           ),
             ),
           ),
         ],
         ),
       )
      ],
      )
    );
  }
}
