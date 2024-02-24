import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import '../utilities/colors.dart';


class Myappbar extends StatefulWidget {
  final bool isDrawerOpen;
  final bool isNotificationOpen;
  final VoidCallback toggleDrawer;
  final VoidCallback toggleNotification;

  const Myappbar({
    Key? key,
    required this.isDrawerOpen,
    required this.isNotificationOpen,
    required this.toggleDrawer,
    required this.toggleNotification,
  }) : super(key: key);

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 15.0),
      child: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 0.20.sh,
              width: 1.sw,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: widget.toggleDrawer,
                    splashColor: AppColors.grey
                        .withOpacity(0.2),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: widget.isDrawerOpen ? null : BoxDecoration(
                          color: AppColors.lightPurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 0.4.w,color: Colors.black.withOpacity(0.5))
                      ),
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.line_horizontal_3,),
                        iconSize: 24.0,
                        onPressed: widget.toggleDrawer,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    splashColor: AppColors.grey.withOpacity(0.2),
                    child: Container(
                      height: 40,
                      width:40.0,
                      decoration: BoxDecoration(
                          color: AppColors.lightPurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 0.4.w,color: Colors.black.withOpacity(0.5))
                      ),
                      child: IconButton(
                        onPressed:widget.toggleNotification,
                        icon: const Icon(CupertinoIcons.bell,
                            color: AppColors.black,size: 24.0
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              top: 7,
                left: 40,
                right: 40,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Text(
                    'Petro Card',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 24.0.sp,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
