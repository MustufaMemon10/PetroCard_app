import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/screens/MainScreen/Card_screen.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/Location_screen.dart';
import '../Components/colors.dart';
import '../screens/MainScreen/User_screen.dart';
class HomeWidget extends StatefulWidget {
  final bool isDrawerOpen;
  final bool isNotificationOpen;
  final VoidCallback toggleDrawer;
  final VoidCallback toggleNotification;

  const HomeWidget({
    Key? key,
    required this.isDrawerOpen,
    required this.isNotificationOpen,
    required this.toggleDrawer,
    required this.toggleNotification,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0,),
        child: Stack(
          children: [
            SizedBox(
              height: 1.sh,
              child: _buildScreenBasedOnIndex(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 40,
              left: widget.isDrawerOpen ? -50 : 10,
              child: InkWell(
                onTap: widget.toggleDrawer,
                splashColor: AppColors.primaryPurple.withOpacity(0.2),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: widget.isDrawerOpen ? null : BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPurple.withOpacity(0.7),
                        blurRadius: 3.0,
                        offset: const Offset(-3, 3),
                      )
                    ]
                  ),
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.line_horizontal_3,),
                    iconSize: 24.0,
                    onPressed: widget.toggleDrawer,
                  ),
                ),
              ),
            ),
             AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 40,
              right:  widget.isNotificationOpen ? -50 : 10 ,
              child: InkWell(
                onTap: () {
                },
                splashColor: AppColors.primaryPurple.withOpacity(0.2),
                child: Container(
                          height: 40,
                          width:40.0,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(color: AppColors.primaryPurple.withOpacity(0.7),
                              blurRadius: 3.0,
                              offset: const Offset(3,3)
                              )
                            ]
                            ),
                          child: TextButton(
                            onPressed:widget.toggleNotification,
                            child: Icon(CupertinoIcons.bell,
                            color: AppColors.black,size: 24.0
                          ),
                        ),
                      ),
              ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: MyNavBar(
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenBasedOnIndex() {
    switch (_currentIndex) {
      case 0:
        return const LocationScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return const CardScreen();
      case 3:
        return const UserScreen();
      default:
        return Container(); // Handle other cases as needed
    }
  }
}