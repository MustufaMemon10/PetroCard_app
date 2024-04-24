import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/StartingScreen/splashscreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        groupKey: 'Group Channel',
        channelKey: "Basic Channel",
        channelName: "PetroApp Notification",
        channelDescription: "Test Notification",
      ledColor: AppColors.white,
    )
  ],channelGroups: [
    NotificationChannelGroup(channelGroupKey: 'Group Channel', channelGroupName: 'Basic Group')
  ]
  );
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              fontFamily: "RobotoMono",
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white,
                elevation: 0,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const PetroCard(),
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
      body: SplashScreen(),
    );
  }
}
