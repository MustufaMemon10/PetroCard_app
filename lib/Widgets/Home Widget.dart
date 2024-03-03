import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/Myappbar.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/screens/MainScreen/CardScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/Location_screen.dart';
import '../screens/MainScreen/User_screen.dart';
class HomeWidget extends StatefulWidget {
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;

  const HomeWidget({
    Key? key,
    required this.isDrawerOpen,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
        Stack(
          children: [
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: _buildScreenBasedOnIndex(),
            ),
            Positioned(
                   top: 0,
                   left: 0,
                   right: 0,
                   child: Myappbar(isDrawerOpen: widget.isDrawerOpen,
                     toggleDrawer: widget.toggleDrawer,
                   ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: MyNavBar(
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildScreenBasedOnIndex() {
    switch (_currentIndex) {
      case 0:
        return const LocationScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return const CardScreen();
      case 3:
        return const UserScreen();
      default:
        return Container();
    }
  }
}