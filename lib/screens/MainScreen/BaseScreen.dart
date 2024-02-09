import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Components/NotificationShade.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/Components/Drawer.dart';
import 'package:petrocardapppp/Widgets/Home Widget.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with SingleTickerProviderStateMixin{
  bool isDrawerOpen = false;
  bool isNotificationOpen = false;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _animationController.forward();
        isNotificationOpen = false;
      } else {
        _animationController.reverse();
      }
    });
  }
  void toggleNotification(){
    setState(() {
      isNotificationOpen = !isNotificationOpen;
      if (isNotificationOpen) {
        isDrawerOpen = false; // Close drawer when opening notification shade
      }
      else{
        isNotificationOpen = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeWidget(
            isDrawerOpen: isDrawerOpen,
            isNotificationOpen: isNotificationOpen,
            toggleDrawer: toggleDrawer,
            toggleNotification: toggleNotification,
          ),
        if (isDrawerOpen || isNotificationOpen) GestureDetector(
          onTap: () {
          if (isDrawerOpen) {
             toggleDrawer();
             } else if (isNotificationOpen) {
              toggleNotification();
             }
               },
               child: Container(
               color: Colors.black.withOpacity(0.4),
             ),
            ),
            AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: isDrawerOpen ? 0 : -450,
            child: const HomeDrawer(),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            right: isNotificationOpen ? 0 : -450,
            child: const NotificationShade(),
          ),
        
        ],
      ),
    );
  }
}