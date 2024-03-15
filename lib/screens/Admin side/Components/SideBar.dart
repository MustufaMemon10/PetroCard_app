import 'package:flutter/material.dart';

import '../../../utilities/colors.dart';

class SideBarMenu extends StatelessWidget {
  SideBarMenu(
      {required this.selectedIndex,
      required this.onTap,
      required this.isExpanded,
      required this.ontap,
      super.key});

  int selectedIndex = 0;
  bool isExpanded = false;
  final Function(int) onTap;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NavigationRail(
              extended: isExpanded,
              backgroundColor: AppColors.white,
              unselectedIconTheme: IconThemeData(color: AppColors.darkPurple),
              unselectedLabelTextStyle: TextStyle(
                color: AppColors.grey,
              ),
              selectedIconTheme: IconThemeData(color: AppColors.darkPurple),
              selectedLabelTextStyle: TextStyle(color: AppColors.darkPurple),
              destinations: [
                NavigationRailDestination(
                  icon: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/Icons/man2.png',
                        height: 36,
                        width: 36,
                      )),
                  label: Text('userName'),
                ),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/activity.png',
                      height: 28,
                      width: 28,
                    ),
                    label: Text('Dashboard')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/group2.png',
                      height: 28,
                      width: 28,
                    ),
                    label: Text('Users')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/interview.png',
                      height: 25.0,
                      width: 25.0,
                    ),
                    label: Text('Card Request')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/credit-card.png',
                      height: 25.0,
                      width: 25.0,
                    ),
                    label: Text('Assign Card')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/rate.png',
                      height: 32.0,
                      width: 32.0,
                    ),
                    label: Text('Feedbacks')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/complain.png',
                      height: 27.0,
                      width: 27.0,
                    ),
                    label: Text('Complaints')),
                NavigationRailDestination(
                    icon: Image.asset(
                      'assets/Icons/logout.png',
                      height: 23,
                      width: 23,
                    ),
                    label: Text('LogOut'))
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: onTap,
            ),
            Positioned(
              right:0,
              top: 5,
              child: IconButton(
                onPressed: () {
                  ontap();
                },
                icon: isExpanded
                    ? Icon(Icons.arrow_back_ios)
                    : Icon(Icons.arrow_forward_ios),
                iconSize: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
