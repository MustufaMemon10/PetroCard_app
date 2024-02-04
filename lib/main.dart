import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/bottom_navigationbar.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/Components/Drawer.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:petrocardapppp/screens/MainScreen/HomeScreen.dart';
import 'package:petrocardapppp/screens/StartingScreen/splashscreen.dart';


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
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          fontFamily: "Poppins",
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            elevation: 0,
          )
        ),
        debugShowCheckedModeBanner: false,
        home:  PetroCard(),
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
    return  Scaffold(
      body:BaseScreen(),
    );
  }
}
