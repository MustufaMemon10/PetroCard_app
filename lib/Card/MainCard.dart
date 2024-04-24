import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class PetroMainCard extends StatefulWidget {
  final String userName;
  final String card_num;

   const PetroMainCard({
    required this.card_num,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  State<PetroMainCard> createState() => _PetroMainCardState();
}

class _PetroMainCardState extends State<PetroMainCard> {
  bool isDark = false;
  bool isBalanceHidden = true;
  String userId = '';
  var data;
  bool isLoading = false;
  var logindata;

  Future<void> _fetchCardDetails() async {
    try {
      SharedPreferences setpreference = await SharedPreferences.getInstance();
      setState(() {
        userId = setpreference.getString('id')!;
      });
      setState(() {
        isLoading = true;
      });
      final loginUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/card_data_fetchapi.php?id=$userId");
      final response = await http.get(loginUrl);
      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = logindata['data'];
        if (!logindata['error']) {
          SharedPreferences setpreference =
              await SharedPreferences.getInstance();
          setpreference.setString('card_id', data[0]['card_id'].toString());
          setpreference.setString('card_num', data[0]['card_num'].toString());
          setpreference.setString('addedtime', data[0]['addedtime'].toString());
          setpreference.setString('cardlimit', data[0]['cardlimit'].toString());
          setpreference.setString('balance', data[0]['balance'].toString());
          setpreference.setString('status', data[0]['status'].toString());
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print(
            'Failed to get response from server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCardDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 0.250.sh,
            width: 380.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0.r),
              border: Border.all(
                  width: 0.4, color: AppColors.white.withOpacity(0.7)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(10, 10),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: isDark
                    ? [
                        AppColors.darkPurple.withOpacity(1),
                        AppColors.red,
                        AppColors.darkPurple.withOpacity(0.3),
                      ]
                    : [
                        AppColors.translightPurple2.withOpacity(1), //
                        AppColors.red.withOpacity(0.8),
                        Color(0xFFFF00FF).withOpacity(0.7),
                      ],
                stops: [0.0, 0.7, 1.0],
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/Icons/card.png',
                      height: 80,
                      width: 80.0,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/Icons/chip (2).png',
                        height: 35.0.h,
                        width: 50.0.h,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: Image.asset(
                          'assets/Icons/contactless.png',
                          height: 50.0.h,
                          color: isDark
                              ? AppColors.white.withOpacity(0.7)
                              : AppColors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.card_num,
                        style: TextStyle(
                          fontSize: 19.0.sp,
                          color: isDark
                              ? AppColors.transparent
                              : AppColors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'RobotoMono',
                          letterSpacing: 0.9,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.userName,
                            style: TextStyle(
                              fontSize: 19.0.sp,
                              color: isDark
                                  ? AppColors.white.withOpacity(0.8)
                                  : AppColors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'RobotoMono',
                              letterSpacing: 0.9,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
