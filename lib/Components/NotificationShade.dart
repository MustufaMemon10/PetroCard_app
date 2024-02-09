import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/NotificationItem.dart';
import 'package:petrocardapppp/Components/colors.dart';

class NotificationShade extends StatefulWidget {
  const NotificationShade({super.key});

  @override
  State<NotificationShade> createState() => _NotificationShadeState();
}

class _NotificationShadeState extends State<NotificationShade> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1.sh,
        width: 0.7.sw,
          padding: EdgeInsets.symmetric(vertical:15.0, horizontal: 15.0 ),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 25.0.sp,
                    ),
                  ),
                    Container(
                      height: 40,
                      width:40.0,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(color: AppColors.primaryPurple.withOpacity(0.7),
                          blurRadius: 3.0,
                          offset: Offset(3,3)
                          )
                        ]
                        ),
                      child: TextButton(onPressed: (){},child: Icon(CupertinoIcons.settings,color: AppColors.black,size: 24.0),)),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            NotificationItem(notTitle: 'New Message', subtitle: 'Your Card has been Locked Successfully!' ),
            NotificationItem(notTitle: 'New Message', subtitle: 'Your Card has Unlocked Successfully'),
             NotificationItem(notTitle: 'New Message', subtitle: 'Your Card Payment Done,'),
              NotificationItem(notTitle: 'New Message', subtitle: 'Your Card request has been approved.'),
          ],
        ),
      ),
    );
  }
}
