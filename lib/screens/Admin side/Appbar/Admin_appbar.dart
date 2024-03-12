import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Card/Request/Request_card.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/screens/MainScreen/User_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAppbar extends StatefulWidget {
  final Function onTap;

  const AdminAppbar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AdminAppbar> createState() => _AdminAppbarState();
}

class _AdminAppbarState extends State<AdminAppbar> {
  String userName = '';
  bool _showWelcomeText = false;
  bool _showPetroApp = false;

  getUserName() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name')!;
    });
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(seconds: 500));
    setState(() {
      _showPetroApp = true;
    });
    await Future.delayed(
        const Duration(seconds: 1500)); // Delay for petro card fade-out
    setState(() {
      _showPetroApp = false;
    });
    await Future.delayed(const Duration(seconds: 300));
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
        color: AppColors.white,
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
                    children: [
                      InkWell(
                        onTap: () {
                          widget.onTap();
                        },
                        splashColor: AppColors.accentColor.withOpacity(0.2),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child:Icon(
                            Icons.menu_rounded,
                            size: 26.0,
                          )
                        ),
                      ),
                    ],
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
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
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
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
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
