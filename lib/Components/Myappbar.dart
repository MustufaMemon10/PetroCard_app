import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Limit/CardLimitScreen.dart';
import 'package:petrocardapppp/Card/Recharge/Recharge_Screen.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/screens/MainScreen/User_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myappbar extends StatefulWidget {
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;
  final bool isDark;
  final bool hasCard;
  const Myappbar({
    Key? key,
    required this.isDark,
    required this.isDrawerOpen,
    required this.toggleDrawer,
    required this.hasCard,
  }) : super(key: key);

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {

  void getuserName()async{
    SharedPreferences setpreference = await SharedPreferences.getInstance();
  setState(() {
    userName = setpreference.getString('name')!;
  });
  }

  String userName = '';
  String userId = '';
  bool _showPetroApp = false;
  bool _showWelcomeText = false;
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
    super.initState();
    _startAnimations();
    getuserName();
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
                          splashColor: widget.isDark
                              ? AppColors.darkAppBarSplashColor.withOpacity(0.2)
                              : AppColors.accentColor.withOpacity(0.2),
                          child: Container(
                            width: 40,
                            decoration: widget.isDrawerOpen
                                ? null
                                : BoxDecoration(
                                    color: widget.isDark ? AppColors.black: AppColors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        width: 0.4.w,
                                        color: widget.isDark
                                            ? AppColors.white
                                            : Colors.black.withOpacity(0.5))),
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.line_horizontal_3,
                              ),
                              color: widget.isDark ? Colors.white : AppColors.black,
                              iconSize: 24.0,
                              onPressed: widget.toggleDrawer,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (widget.hasCard)
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const CardLimitScreen(),
                                    ),
                                  );
                                },
                                splashColor: widget.isDark
                                    ? AppColors.darkAppBarSplashColor
                                        .withOpacity(0.2)
                                    : AppColors.grey.withOpacity(0.2),
                                child: widget.isDark ? Image.asset('assets/Icons/up-and-down.png',height: 28,width: 35,color: AppColors.black,)
                              :Image.asset('assets/Icons/up-and-down (1).png',height: 28,width: 35,color: AppColors.grey,)
                              ),
                            SizedBox(
                              width: 10.0,
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
                              splashColor: widget.isDark
                                  ? AppColors.black
                                      .withOpacity(0.2)
                                  : AppColors.white,
                              child: UserIcon(isDark: widget.isDark,),
                            ),
                          ],
                        ),
                      ]),
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
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: widget.isDark
                              ? AppColors.darkPrimaryTitle
                              : AppColors.black,
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
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: widget.isDark
                                    ? AppColors.darkPrimaryTitle
                                    : AppColors.black,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
