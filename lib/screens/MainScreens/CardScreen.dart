import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Card/MainCard.dart';
import '../../utilities/colors.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool isDark = false;
  String userName = '';
  String email = '';
  String card_num = '';
  String balance = '';
  String status = '';
  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
      status = setpreference.getString('status') ?? '';

    });
  }
  @override
  void initState() {
    super.initState();
    getCardDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(children: [
          SizedBox(
            height: 70.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Card',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
          PetroMainCard(userName: userName,card_num: card_num,),
          SizedBox(height: 10.0,),
          Divider(),
          ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.white.withAlpha(20)),
                child: Icon(
                  FontAwesomeIcons.creditCard,
                  color: AppColors.darkPurple,
                ),
              ),
              title: Text(
                card_num,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.black,
                  letterSpacing: 0.8,
                ),
              ),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.white.withAlpha(20)),
              child: Icon(
                FontAwesomeIcons.userCheck,
                color: AppColors.darkPurple,
              ),
            ),
            title: Text(
              userName,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.black,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.white.withAlpha(20)),
              child: Icon(
                FontAwesomeIcons.envelope,
                color: AppColors.darkPurple,
              ),
            ),
            title: Text(
              email,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.black,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.white.withAlpha(20)),
              child: Icon(
                FontAwesomeIcons.creativeCommonsSampling,
                color: AppColors.darkPurple,
              ),
            ),
            title: Text(
              status,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.black,
                letterSpacing: 0.8,
              ),
            ),
            trailing: Icon(Icons.radio_button_off_outlined,color: Colors.green,),
          ),
        ]),
      ),
    );
  }
}
