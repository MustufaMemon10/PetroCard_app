import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:petrocardapppp/Components/Myappbar.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/screens/MainScreen/CardScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/Location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/API/ApiHelper.dart';
import '../screens/Admin side/Request_Card/RequestCardScreen.dart';

class HomeWidget extends StatefulWidget {
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;
  final bool isDark;

  const HomeWidget({
    Key? key,
    required this.isDark,
    required this.isDrawerOpen,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 1;
  bool hasCard = true;
  String? userId;
  Future<void> checkHasCard(String id) async {
    bool cardStatus = await ApiHelper.checkHasCard(userId!);
    setState(() {
      hasCard = cardStatus;
    });
  }
  @override
  void initState() {
    super.initState();
    getId();
  }
  Future<void> getId() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userId = setpreference.getString('id') ?? '';
    });
    await checkHasCard(userId!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
            child: Myappbar(
              isDrawerOpen: widget.isDrawerOpen,
              isDark: widget.isDark,
              toggleDrawer: widget.toggleDrawer,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
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
    if (_currentIndex == 0) {
      return const LocationScreen();
    } else if (_currentIndex == 1) {
      if (hasCard) {
        return const HomeScreen();
      } else {
        return const RequestCardScreen(); // Change to check request screen
      }
    } else if (_currentIndex == 2) {
      if (hasCard) {
        return const CardScreen();
      } else {
        return const RequestCardScreen();
      }
    }
    return Container(); // Return an empty container if index is not 0, 1, or 2
  }
}
