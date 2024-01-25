import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'WalkThrough.dart';

void main() => runApp(MaterialApp(
  theme:
  ThemeData(primaryColor: Color(0xFF08364B)),
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getString('id') != null) {
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
    // }else{
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => WalkThrough()), (
        Route<dynamic> route) => false);
  // }
  }

  @override
  void initState(){
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 3));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

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
        backgroundColor: Color(0xFFffffff),
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(24),
                    child:Lottie.asset('assets/images/SplashScreen_animation.json',repeat: false) ,),
                  Text('Petro Card',
                    style: TextStyle(
                        color: Color(0xFF032737),
                        fontSize: 36,
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