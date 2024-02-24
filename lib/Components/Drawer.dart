import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/DrawerComponents/side_menu_tile.dart';
import 'package:petrocardapppp/DrawerComponents/userdetails.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  int selectedIndex = 0; // Track the selected index

  // Define the list of SidemenuTiles
  final List<SlidermenuItem> slidermenuItem = [
    SlidermenuItem(title: 'Rate Us', iconData: CupertinoIcons.star, onTap: (String ) { const HomeDrawer(); },),
    SlidermenuItem(title: 'Feedback', iconData: CupertinoIcons.exclamationmark_bubble,  onTap: (String ) { const HomeDrawer();}),
    SlidermenuItem(title: 'About us', iconData: CupertinoIcons.personalhotspot,  onTap: (String ) { const HomeDrawer();}),
    SlidermenuItem(title: 'Log Out', iconData: Icons.arrow_back_ios,  onTap: (String ) { const HomeDrawer();}),
    SlidermenuItem(title: 'Settings',isSetting: true, iconData: Icons.settings,  onTap: (String) { const HomeDrawer();}),
  ];

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
              SlidermenuItem(title: 'Rate Us', iconData: CupertinoIcons.star, onTap: (String ) { const HomeDrawer(); },),
              SlidermenuItem(title: 'Feedback', iconData: CupertinoIcons.exclamationmark_bubble,  onTap: (String ) { const HomeDrawer();}),
              SlidermenuItem(title: 'About us', iconData: CupertinoIcons.personalhotspot,  onTap: (String ) { const HomeDrawer();}),
              SlidermenuItem(title: 'Log Out', iconData: Icons.arrow_back_ios,  onTap: (String ) { const HomeDrawer();}),
              SizedBox(height: 0.38.sh,),
              SlidermenuItem(title: 'Settings',isSetting: true, iconData: CupertinoIcons.settings,  onTap: (String) { const HomeDrawer();}),
    ]
            ),
      ),
          );
  }
}


