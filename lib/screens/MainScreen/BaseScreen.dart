import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';
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
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          HomeWidget(
            isDrawerOpen: isDrawerOpen,
            isDark: isDark,
            toggleDrawer: toggleDrawer,
          ),
        if (isDrawerOpen) GestureDetector(
          onTap: () {
            if (isDrawerOpen) {
              toggleDrawer();
            }
          },
               child: Container(
               color: AppColors.black.withOpacity(0.4),
             ),
            ),
            AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: isDrawerOpen ? 0 : -450,
            child: const HomeDrawer(),
          ),
        ],
      ),
    );
  }
}