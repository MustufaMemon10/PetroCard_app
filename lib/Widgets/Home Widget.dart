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
  bool isLoading = true;
  String? userName;
  String? card_num;
  var data;
  var logindata;
  @override
  void initState() {
    super.initState();
    checkHasCard();
  }
  Future<void> _fetchCardDetails() async {
    try {
      SharedPreferences setpreference = await SharedPreferences.getInstance();
      setState(() {
        userId = setpreference.getString('id')!;
      });
      setState(() {
        isLoading = true;
      });
      final loginUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/card_data_fetchapi.php?id=$userId");
      final response = await http.get(loginUrl);
      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = logindata['data'];
        if (!logindata['error']) {
          SharedPreferences setpreference =
          await SharedPreferences.getInstance();
          setpreference.setString('card_id', data[0]['card_id'].toString());
          setpreference.setString('card_num', data[0]['card_num'].toString());
          setpreference.setString('addedtime', data[0]['addedtime'].toString());
          setpreference.setString('cardlimit', data[0]['cardlimit'].toString());
          setpreference.setString('balance', data[0]['balance'].toString());
          setpreference.setString('status', data[0]['status'].toString());
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print(
            'Failed to get response from server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
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
            hasCard = false;
            isLoading = false;
          });
        }
        else{
          setpreference.setString('dob', responseData['data']['dob'].toString());
          setpreference.setString('gender', responseData['data']['gender'].toString());
          setState(() {
            hasCard = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
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
          SizedBox(height: 10,),
          Text('Please Wait ...',style: TextStyle(color: AppColors.darkPurple,fontSize: 20,fontWeight: FontWeight.w500),)
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
        return hasCard ?  HomeScreen() :  RequestCardScreen(userId: userId,);
      case 2:
        return hasCard ?  CardScreen() :  RequestCardScreen(userId: userId,);
      default:
        return Container();
    }
  }
}