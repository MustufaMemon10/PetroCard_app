import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Card/MainCard.dart';
import '../../utilities/colors.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String userName = '';
  String email = '';
  String card_num = '';
  String validate = '';
  String balance = '';
  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
      validate = setpreference.getString('validate') ?? '';
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
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
          PetroMainCard(userName: userName,card_num: card_num,validate: validate,),
          SizedBox(height: 10.0,),
          Divider(),

        ]),
      ),
    );
  }
}
