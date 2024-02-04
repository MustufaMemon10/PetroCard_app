import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/Widgets/GreetingWidget.dart';
import 'package:petrocardapppp/Widgets/Transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: .5.sh,
        width: 1.sw,
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
        color: AppColors.white
      ,
        child: const Text('are you good <3'),
            );
  }
}
