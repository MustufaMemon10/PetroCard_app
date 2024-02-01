import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Pages/Forgot%20Password/ChangePasswordScreen.dart';
import 'package:petrocardapppp/Pages/Forgot%20Password/Check%20Number.dart';
import 'package:petrocardapppp/Pages/HomeScreen/HomePage.dart';
import 'package:petrocardapppp/Pages/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/Pages/StartingScreen/splashscreen.dart';


void main() async {
  runApp(const Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, widget) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PetroCard(),
      );
    },
  );
}


class PetroCard extends StatefulWidget {
  const PetroCard({super.key});

  @override
  State<PetroCard> createState() => _PetroCardState();
}

class _PetroCardState extends State<PetroCard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}
