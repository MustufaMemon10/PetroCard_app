import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String userName = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  String DOB = '';

  getUserName() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    userName = setpreference.getString('name')!;
    email = setpreference.getString('email')!;
    password = setpreference.getString('password')!;
    phone= setpreference.getString('phone')!;
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
              onPressed: () {},
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
                email ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
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
                  onPressed: () {},
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
                icon: FontAwesomeIcons.userTag,
                textfield: userName,
              ),    ProfileOptionwidget(
                iconColor: iconColor,
                icon: FontAwesomeIcons.userTag,
                textfield: email,
              ),    ProfileOptionwidget(
                iconColor: iconColor,
                icon: FontAwesomeIcons.userTag,
                textfield: password,
              ),    ProfileOptionwidget(
                iconColor: iconColor,
                icon: FontAwesomeIcons.userTag,
                textfield: phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptionwidget extends StatelessWidget {
  const ProfileOptionwidget(
      {super.key,
      required this.iconColor,
      required this.icon,
      required this.textfield,
      });

  final Color iconColor;
  final IconData icon;
  final String textfield;

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
      trailing: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.2)),
        child: Icon(
          FontAwesomeIcons.angleRight,
          color: Colors.grey,
        ),
      ),
    );
  }
}
