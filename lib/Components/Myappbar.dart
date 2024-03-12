import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Request/Request_card.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/screens/MainScreen/User_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myappbar extends StatefulWidget {
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;
  final bool isDark;
  const Myappbar({
    Key? key,
    required this.isDark,
    required this.isDrawerOpen,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  String userName = '';
  bool _showPetroApp = false;
  bool _showWelcomeText = false;

  getUserName() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name')!;
    });
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _showPetroApp = true;
    });
    await Future.delayed(
        const Duration(seconds: 2)); // Delay for petro card fade-out
    setState(() {
      _showPetroApp = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _showWelcomeText = true;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
    _startAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.darkAppBarBackground : AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SafeArea(
          child: SizedBox(
            height: 0.048.sh,
            width: 1.sw,
            child: Stack(
              children: [
                Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: widget.toggleDrawer,
                          splashColor: widget.isDark ? AppColors.darkAppBarSplashColor.withOpacity(0.2) : AppColors.accentColor.withOpacity(0.2),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: widget.isDrawerOpen
                                ? null
                                : BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    width: 0.4.w,
                                    color: widget.isDark ? AppColors.darkAppBarBorderColor : Colors.black.withOpacity(0.5))),
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.line_horizontal_3,
                              ),
                              iconSize: 24.0,
                              onPressed: widget.toggleDrawer,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const Request_Screen(),
                                  ),
                                );
                              },
                              splashColor: widget.isDark ? AppColors.darkAppBarSplashColor.withOpacity(0.2) : AppColors.grey.withOpacity(0.2),
                              child: Container(
                                height: 35,
                                width: 35.0,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.w,
                                        color: widget.isDark ? AppColors.darkAppBarBorderColor : Colors.black.withOpacity(0.5))),
                                child: Icon(Icons.add),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const UserScreen(),
                                  ),
                                );
                              },
                              splashColor: widget.isDark ? AppColors.darkAppBarSplashColor.withOpacity(0.2) : AppColors.grey.withOpacity(0.2),
                              child: UserIcon(),
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
                AnimatedPositioned(
                  top: _showWelcomeText ? -50 : 0,
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Petro App',
                        style:TextStyle(   fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: widget.isDark ? AppColors.darkPrimaryTitle : AppColors.black,
                      ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  top: _showWelcomeText ? 0 : -50,
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: userName.isNotEmpty
                          ? Text(
                        'Welcome ' +
                            userName
                                .split(' ')[0]
                                .substring(0, 1)
                                .toUpperCase() +
                            userName.split(' ')[0].substring(1),
                        // Start from index 1 to get the rest of the string
                        style:TextStyle( fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: widget.isDark ? AppColors.darkPrimaryTitle : AppColors.black,
                        ),
                      )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),)
        ,
      ),
    );
  }
}
