import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.21.sh,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Search Petrol Station",style: AppStyles.locationText,),
                ),
                SizedBox(height: 10.0.h,),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15.0.r),
                      border: Border.all(color: AppColors.black.withOpacity(0.7),width: 0.8)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        hintStyle: AppStyles.Textfield_hintstyle,
                        hintText: "Area"),
                  ),
                ),
                SizedBox(height: 10.0.h,),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15.0.r),
                      border: Border.all(color: AppColors.black.withOpacity(0.7),width: 0.8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: "City",
                        hintStyle: AppStyles.Textfield_hintstyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Container(
                  height: 35.h,
                  width: 0.6.sw,
                  decoration: BoxDecoration(
                    color: AppColors.darkPurple.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30.0.r),
                    border: Border.all(color: AppColors.white.withOpacity(0.5),width: 0.8)
                  ),
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
