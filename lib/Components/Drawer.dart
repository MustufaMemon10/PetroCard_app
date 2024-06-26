import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/DrawerComponents/AboutUspage.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/DrawerComponents/side_menu_tile.dart';
import 'package:petrocardapppp/DrawerComponents/userdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Admin side/Complain/add_complaints_page.dart';
import '../screens/Admin side/Feedback/add_feedback_page.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key});
  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1.sh,
        width: 0.7.sw,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            right: BorderSide(width: 1.w,color: AppColors.black.withOpacity(0.3))
          )
        ),
        child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const User_details(),
              SlidermenuItem(title: 'Feedback', iconData: CupertinoIcons.star, onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> AddFeedbackPage()));
              },),
              SlidermenuItem(title: 'Complaint', iconData: CupertinoIcons.exclamationmark_bubble,  onTap:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> AddComplaintsPage()));
              }),
              SlidermenuItem(title: 'About us', iconData: CupertinoIcons.personalhotspot,  onTap: () {   Navigator.push(context, MaterialPageRoute(builder:(context)=> AboutUsPage()));}),
              SlidermenuItem(title: 'Log Out',
                  iconData: Icons.logout,
                  onTap: () async{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Logout Confirmation"),
                        content:
                        Text("Are you sure you want to Logout?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false);
                            },
                            child: Text("Cancel",style: TextStyle(color: AppColors.darkPurple.withOpacity(0.9)),),
                          ),
                          TextButton(
                            onPressed: () async{
                              final pref = await SharedPreferences.getInstance();
                              await pref.clear();
                              await pref.remove('seen');
                              await pref.setBool('seen',true);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                      (route) => false);
                            },
                            child: Text("Logout",style: TextStyle(color: AppColors.darkPurple),),
                          ),
                        ],
                      ),
                    );
                  }
               ),
    ]
            ),
      ),
          );
  }
}


