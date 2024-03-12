import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utilities/colors.dart';

class SideBarMenu extends StatelessWidget {
   SideBarMenu({
    required this.selectedIndex,
    required this.onTap,
    required this.isExpanded,
     required this.ontap,
    super.key});

  final int selectedIndex;
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
                unselectedIconTheme:
                IconThemeData(color: AppColors.grey),
                unselectedLabelTextStyle: TextStyle(
                  color: AppColors.grey,
                ),
                selectedIconTheme:
                IconThemeData(color: AppColors.darkPurple),
                selectedLabelTextStyle:
                TextStyle(color: AppColors.darkPurple),
                destinations: [
                  NavigationRailDestination(icon: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/Icons/man.png', height: 36, width: 36,)),
                    label: Text('userName'),),
                  NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/svgs/home.svg',
                        height: 23.0,
                        width: 23.0,
                      ), label: Text('Home')),
                  NavigationRailDestination(
                      icon: Icon(Icons.supervised_user_circle_sharp),
                      label: Text('Home')),
                  NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/svgs/credit-card.svg',
                        height: 25.0,
                        width: 25.0,
                      ),
                      label: Text('Home')),
                  NavigationRailDestination(

                      icon: Icon(Icons.logout_sharp), label: Text('LogOut'))
                ],
                selectedIndex: selectedIndex),
            Positioned(right: 5, top: 5,
              child: IconButton(
                onPressed: () {
                  ontap();
                },
                icon: isExpanded ? Icon(Icons.arrow_back_ios) : Icon(
                    Icons.arrow_forward_ios),
                iconSize: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
