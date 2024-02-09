import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/DrawerComponents/InfoCard.dart';
import 'package:petrocardapppp/DrawerComponents/side_menu_tile.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  int selectedIndex = 0; // Track the selected index

  // Define the list of SidemenuTiles
  final List<SlidermenuItem> slidermenuItem = [
    SlidermenuItem(title: 'Rate Us', iconData: CupertinoIcons.star, onTap: (String ) { HomeDrawer(); },),
    SlidermenuItem(title: 'Feedback', iconData: CupertinoIcons.exclamationmark_bubble,  onTap: (String ) { HomeDrawer();}),
    SlidermenuItem(title: 'About us', iconData: CupertinoIcons.personalhotspot,  onTap: (String ) { HomeDrawer();}),
    SlidermenuItem(title: 'Log Out', iconData: Icons.arrow_back_ios,  onTap: (String ) { HomeDrawer();}),
    SlidermenuItem(title: 'Settings',isSetting: true, iconData: Icons.settings,  onTap: (String) { HomeDrawer();}),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1.sh,
        width: 0.7.sw,
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.7),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.black12,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: Image.asset(
                        'assets/Animations/1684996885825.jpg')
                        .image,
                  ),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                 Text(
                  'Mustufa Memon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              // Use ListView.builder to build the list dynamically
              ListView.builder(
                shrinkWrap: true,
                itemCount: slidermenuItem.length,
                itemBuilder: (context, index) {
                  final tile = slidermenuItem[index];
                  return  tile;
                  }
                    ),
                     ]
                  ),
        ),
              ),
          );
  }
}


