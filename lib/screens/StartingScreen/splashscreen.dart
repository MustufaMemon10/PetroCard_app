import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/screens/Admin%20side/Components/Base_dashboard.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? role = prefs.getString('role');

    if (id != null) {
      if (role == '0') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => AdminDashboard()),
        );
      } else if (role == '1') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => BaseScreen()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      );
    }
  }


  // Future<void> checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('id') != null) {
  //     if (prefs.getString('role') == 1) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (BuildContext context) => BaseScreen()),
  //       );
  //     } else if (prefs.getString('role') == 0) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //             builder: (BuildContext context) => AdminDashboard()),
  //       );
  //     }
  //   }
  // }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, checkFirstSeen);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/Animations/splashimage.png',
                  height: 80,
                  width: 80,
                ),
              ),
              Text(
                'Petro Card',
                style: TextStyle(
                  color: Color(0xFF032737),
                  fontSize: 19,
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
