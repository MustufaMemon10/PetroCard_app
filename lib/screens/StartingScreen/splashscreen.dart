import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petrocardapppp/screens/Admin%20side/Base_dashboard.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/screens/StartingScreen//WalkThrough.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, checkFirstSeen);
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('id') != null || prefs.getString('role') == 1) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => BaseScreen()), (
          Route<dynamic> route) => false);
    }
      else if(prefs.getString('id') != null || prefs.getString('role') == 0) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => AdminDashboard()), (Route<dynamic> route) => false);
    }else{
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => LoginPage()), (
        Route<dynamic> route) => false);
  }
  }
  void dispose() {
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    animationController =  AnimationController(
        vsync: this, duration:  Duration(seconds: 3));
    animation =
     CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Image.asset('assets/Animations/splashimage.png',height:70,width: 70,)),
                  Text('Petro Card',
                    style: TextStyle(
                        color: Color(0xFF032737),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            ),
        );
    }
}