import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Request/Request_card.dart';
import 'package:petrocardapppp/DrawerComponents/Rating_popup.dart';
import 'package:petrocardapppp/screens/LoginScreen/LoginPage.dart';
import 'package:petrocardapppp/screens/LoginScreen/Signup.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/Location_screen.dart';
import 'package:petrocardapppp/screens/StartingScreen/splashscreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';

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
      return  MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            fontFamily: "RobotoMono",
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
              elevation: 0,
            ),
        ),
        debugShowCheckedModeBanner: false,
        home:  const PetroCard(),
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
    return Scaffold(
      body: Request_Screen(),
    );
  }
}