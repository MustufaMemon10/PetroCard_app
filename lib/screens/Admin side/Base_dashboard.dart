import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petrocardapppp/screens/Admin%20side/Manage_Users/Manage_User.dart';
import 'package:petrocardapppp/screens/Admin%20side/SideBar.dart';
import 'package:petrocardapppp/screens/Admin%20side/Appbar/Admin_appbar.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isSideBarOpen = false;
  bool isExpanded = false;
  int _selectedIndex = 0;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  isSideBarOpen = false;
                  isExpanded = false;
                });
              },
              child:  ManageUserScreen(),
          ),
          AnimatedPositioned(
            left: 0,
            right: 0,
            duration: Duration(milliseconds: 400),
            child: AdminAppbar(
              onTap: () {
                setState(() {
                  isSideBarOpen = !isSideBarOpen;
                });
              },
            ),
          ),
          AnimatedPositioned(
            left: isSideBarOpen ? -10 : -150, // Adjust this value as needed
            duration: Duration(milliseconds: 400),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: isExpanded ?200 :140,
              height: MediaQuery.of(context).size.height,
              child: SideBarMenu(
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    currentIndex = index;
                  });
                },
                ontap: (){
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                isExpanded: isExpanded,
                selectedIndex: _selectedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenBasedOnIndex() {
    switch (currentIndex) {
      case 0:
        return ManageUserScreen();
      case 1:
        return ManageUserScreen ();
      case 2:
        return  ManageUserScreen();
      default:
        return Container();
    }
  }
}

