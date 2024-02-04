import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/Components/Drawer.dart';
import 'package:petrocardapppp/Widgets/Home Widget.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool isDrawerOpen = false;
  bool isIconPressed = false;
  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      isIconPressed = !isIconPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeWidget(),
          AnimatedPositioned(
              left: isDrawerOpen ? 0 : 0.7,
              duration: const Duration(milliseconds:600),
              child: isDrawerOpen? const HomeDrawer():const SizedBox()),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 30.0,
            left: isDrawerOpen ? 0.7.sw : 10.w,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: isDrawerOpen? 34 : 34,
              width:  isDrawerOpen? 34 : 34,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: toggleDrawer,
                child:Icon(
                  isDrawerOpen ? FontAwesomeIcons.xmark : Icons.menu,
                  color: AppColors.darkPurple,
                  size: isDrawerOpen? 34 : 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
