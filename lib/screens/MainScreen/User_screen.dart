import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/screens/Forgot%20Passwordscreen/ChangePasswordScreen.dart';
import 'package:petrocardapppp/screens/Profile_screen/Update_profile_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isDark = false;
  var data;
  var logindata;

  bool isLoading = false;
  String id = '';
  String userName = '';
  String email = '';
  String phone = '';
  String address = '';
  String DOB = '';
  String timestamp = '';
  String gender = '';

  Future<void> fetchOtherDetails() async {
    setState(() {
      isLoading = true;
    });
    try {
      final loginUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/fetch_cardrequestapi.php?id=$id");
      final response = await http.get(loginUrl);

      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = logindata['data'];
        print(logindata);

        if (!logindata['error']) {
          print('$id');
          SharedPreferences setpreference =
              await SharedPreferences.getInstance();
          setpreference.setString('req_date', data[0]['req_date'].toString());
          setpreference.setString('status', data[0]['status'].toString());
          setpreference.setString('address', data[0]['address'].toString());
          setpreference.setString('dob', data[0]['dob'].toString());
          setpreference.setString('gender', data[0]['gender'].toString());
          setpreference.setString(
              'pan_number', data[0]['pan_number'].toString());
          print('address : $address');
          print('gender : $gender');
          print('dob : $DOB');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print(
            'Failed to get response from server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getUserDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      id = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      phone = setpreference.getString('phone') ?? '';
      address = setpreference.getString('address') ?? '';
      DOB = setpreference.getString('dob') ?? '';
      gender = setpreference.getString('gender') ?? '';
      print('$id');
    });
    await fetchOtherDetails();
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textColor = isDark ? AppColors.white : AppColors.black;
    var lTextColor = isDark
        ? AppColors.white.withOpacity(0.4)
        : AppColors.black.withOpacity(0.4);
    var iconColor = isDark ? AppColors.primaryPurple : AppColors.darkPurple;
    return Stack(
      children: [
        Scaffold(
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
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
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
                        child: UserIcon()),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Text(userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.8,
                        fontSize: 16.0,
                        color: textColor,
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: lTextColor,
                      letterSpacing: 0.8,
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
                        backgroundColor: isDark
                            ? AppColors.darkPurple
                            : AppColors.translightPurple,
                        side: BorderSide.none,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
                          color: textColor,
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
                    isDark: isDark,
                    icon: FontAwesomeIcons.userCheck,
                    textfield: userName,
                  ),
                  ProfileOptionwidget(
                    iconColor: iconColor,
                    isDark: isDark,
                    icon: FontAwesomeIcons.envelope,
                    textfield: email,
                  ),
                  ProfileOptionwidget(
                    iconColor: iconColor,
                    isDark: isDark,
                    icon: FontAwesomeIcons.phone,
                    textfield: phone,
                  ),
                  ProfileOptionwidget(
                    iconColor: iconColor,
                    isDark: isDark,
                    icon: FontAwesomeIcons.fingerprint,
                    textfield: '********',
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                    trailing: true,
                  ),
                  if (DOB.isNotEmpty)
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      isDark: isDark,
                      icon: FontAwesomeIcons.calendar,
                      textfield: DOB,
                    ),
                  if (address.isNotEmpty)
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      isDark: isDark,
                      icon: FontAwesomeIcons.addressBook,
                      textfield: address,
                    ),
                  if (gender.isNotEmpty)
                    ProfileOptionwidget(
                      iconColor: iconColor,
                      isDark: isDark,
                      icon: FontAwesomeIcons.person,
                      textfield: gender,
                    ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Text(timestamp,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: isLoading ? AppColors.black.withOpacity(0.4) : null,
            child: isLoading
                ? Center(
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: AppColors.darkPurple,
                      rightDotColor: AppColors.white,
                      size: 50,
                    ),
                  )
                : null,
          ),
        ),
      ],
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
    this.onTap,
    required this.isDark,
    this.isPassword = false,
  });

  final Color iconColor;
  final IconData icon;
  final String textfield;
  final Function()? onTap;
  final bool trailing;
  final bool isDark;
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
          style: TextStyle(
            fontSize: 16.0,
            color: isDark ? AppColors.white : AppColors.black,
            letterSpacing: 0.5,
          ),
        ),
        trailing: trailing
            ? GestureDetector(
                onTap: onTap,
                child: Container(
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
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              )
            : null);
  }
}
