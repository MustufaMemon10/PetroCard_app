import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/Myappbar.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/screens/MainScreen/CardScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/Location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Card/Request/Request_Card_Screen.dart';
import '../Card/Request_Card/RequestCardScreen.dart';
import '../screens/API/ApiHelper.dart';

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
  bool hasCard = false;
  String userId = '';
  @override
  void initState() {
    super.initState();
    _fetchUserIdAndCardStatus();
  }
  Future<void> checkHasCard(String id) async {
    try {
      bool cardStatus = await ApiHelper.checkHasCard(userId);
      setState(() {
        hasCard = cardStatus;
      });
    } catch (e) {
      print('Error checking card status: $e');
    }
  }
  Future<void> _fetchUserIdAndCardStatus() async {
    try {
      SharedPreferences setpreference = await SharedPreferences.getInstance();
      setState(() {
        userId = setpreference.getString('id') ?? '';
      });
      await checkHasCard(userId);
    } catch (e) {
      print('Error fetching data: $e');
    }
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
    switch (_currentIndex) {
      case 0:
        return const LocationScreen();
      case 1:
        return hasCard ? const Request_Screen() : const Request_Screen();
      case 2:
        return hasCard ? const RequestCardScreen() : const RequestCardScreen();
      default:
        return Container();
    }
  }
}