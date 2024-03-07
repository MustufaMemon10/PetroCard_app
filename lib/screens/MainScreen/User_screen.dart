import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/Profile_screen/Update_profile_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isDark = false;

  String userName = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  String DOB = '';
  String timestamp = '';
  String gender = '';

  Future<void> getUserDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      phone = setpreference.getString('phone') ?? '';
      DOB = setpreference.getString('dob') ?? '';
      address = setpreference.getString('address') ?? '';
      timestamp = setpreference.getString('timestamp') ?? '';
    });
  }


  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var iconColor = isDark ? AppColors.primaryPurple : AppColors.darkPurple;
    return Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            appBar: AppBar(
              backgroundColor: isDark ? AppColors.black : AppColors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(FontAwesomeIcons.angleLeft,
                    color: isDark ? AppColors.white : AppColors.black),
              ),
              title: Center(
                  child: Text(
                'Profile',
                style: TextStyle(
                    color: isDark ? AppColors.white : AppColors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800),
              )),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon: Icon(isDark ? FontAwesomeIcons.moon : Icons.sunny,
                        color: isDark ? AppColors.white : AppColors.black))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/Icons/man.png')),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Text(userName,
                        textAlign: TextAlign.center,
                        style: AppStyles.otherDetailsPrimary),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? AppColors.white: AppColors.secondaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const UpdateProfileScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkPurple,
                          side: BorderSide.none,
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: isDark ? AppColors.black : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(),
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.userCheck,
                      textfield: userName,
                    ),
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.envelope,
                      textfield: email,
                    ),
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.phone,
                      textfield: phone,
                    ),
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.fingerprint,
                      textfield: '********',
                      trailing: true,
                    ),
                    if(DOB.isNotEmpty)
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.calendar,
                      textfield: DOB,
                    ),
                    if(address.isNotEmpty)
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.addressBook,
                      textfield: address,
                    ),
                    if(gender.isNotEmpty)
                      ProfileOptionwidget(
                      iconColor: iconColor,
                      icon: FontAwesomeIcons.person,
                      textfield: gender,
                    ),
                    SizedBox(height: 40.0,),
                    Center(child:
                      Text(
                        timestamp,
                        style: AppStyles.otherDetailsPrimary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        // : Scaffold(
        //   backgroundColor: isDark ?AppColors.black:AppColors.backgroundColor,
        //   body: Center(
        //       child: LoadingAnimationWidget.flickr(
        //         leftDotColor: AppColors.darkPurple,
        //         rightDotColor: AppColors.accentColor,
        //         size: 50,
        //       ),
        //     ),
        // );
  }
}

class ProfileOptionwidget extends StatelessWidget {
  const ProfileOptionwidget({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.textfield,
    this.trailing = false,
    this.isPassword = false,
  });

  final Color iconColor;
  final IconData icon;
  final String textfield;
  final bool trailing;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: iconColor.withOpacity(0.2)),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          textfield,
          style: AppStyles.otherDetailsPrimary,
        ),
        trailing: trailing
            ? Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.2)),
                child: Center(
                  child: Text(
                    'change',
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              )
            : null);
  }
}
