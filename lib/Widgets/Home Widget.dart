import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/Components/Myappbar.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/screens/MainScreens/CardScreen.dart';
import 'package:petrocardapppp/screens/MainScreens/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreens/Location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Card/Request_Card/CheckRequest.dart';
import '../utilities/colors.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkHasCard();
  }
  Future<void> checkHasCard() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl = 'https://petrocard.000webhostapp.com/API/checkUserhasCard.php';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': setpreference.getString('id')},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['error']== true) {
          setState(() {
            hasCard = true;
          });
        }
        else{
          setState(() {
            hasCard = false;
          });
        }
      } else {
      }
    } catch (error) {
      print('No connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.halfTriangleDot(
            color: AppColors.darkPurple,
            size: 50,
          ),
        ],
      ),
    )
        : Scaffold(
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
              hasCard: hasCard,
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
        return  RequestCardScreen(userId: userId,);
      case 2:
        return hasCard ? const CardScreen() :  RequestCardScreen(userId: userId,);
      default:
        return Container();
    }
  }
}