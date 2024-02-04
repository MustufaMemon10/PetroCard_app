import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/DrawerComponents/InfoCard.dart';
import 'package:petrocardapppp/DrawerComponents/side_menu_tile.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  int selectedIndex = 0; // Track the selected index

  // Define the list of SidemenuTiles
  final List<SidemenuTile> sidemenuTiles = [
    SidemenuTile(title: 'Rate Us', icon: CupertinoIcons.star, page: HomeDrawer()),
    SidemenuTile(title: 'Feedback', icon: CupertinoIcons.exclamationmark_bubble, page: HomeDrawer()),
    SidemenuTile(title: 'About us', icon: CupertinoIcons.personalhotspot, page: HomeDrawer()),
    SidemenuTile(title: 'Log Out', icon: CupertinoIcons.rectangle_expand_vertical, page: HomeDrawer()),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 1.sh,
          width: .7.sw,
          decoration: BoxDecoration(
            color: AppColors.darkPurple.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoCard(name: 'Abu Usman', email: 'Abu12@gmail.com'),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 32.0, bottom: 16.0,),
                  child: Text(
                    'Browse'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                  ),
                ),
                // Use ListView.builder to build the list dynamically
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: sidemenuTiles.length,
                  itemBuilder: (context, index) {
                    final tile = sidemenuTiles[index];
                    return GestureDetector(
                      onTap: () {
                        // Update the selected index on tile tap
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: tile,
                    );
                    }
                      ),
                       ]
                    ),
          ),
                ),
      ),
          );
  }
}


