import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrocardapppp/utilities/colors.dart';
class PetroMainCard extends StatefulWidget {

  const PetroMainCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PetroMainCard> createState() => _PetroMainCardState();
}

class _PetroMainCardState extends State<PetroMainCard> {
  bool isDark = false;
  bool isBalanceHidden = true;
  String id = '';
  String userName = '';
  String email = '';
  String card_num = '';
  String validate = '';
  String balance = '';
  var data;
  var logindata;
  bool isLoading = false;

  Future<void> fetchCardDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final loginUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/card_data_fetchapi.php?id=$id");
      final response = await http.get(loginUrl);

      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = logindata['data'];
        print(logindata);

        if (!logindata['error']) {
          SharedPreferences setpreference =
          await SharedPreferences.getInstance();
          setpreference.setString('card_id', data[0]['card_id'].toString());
          setpreference.setString('card_num', data[0]['card_num'].toString());
          setpreference.setString('addedtime', data[0]['addedtime'].toString());
          setpreference.setString('validate', data[0]['validate'].toString());
          setpreference.setString('balance', data[0]['balance'].toString());
          setpreference.setString(
              'status', data[0]['status'].toString());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print(
            'Failed to get response from server. Status code: ${response
                .statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      id = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
      validate = setpreference.getString('validate')?? '';
    });
    await fetchCardDetails();
  }
  @override
  void initState() {
    super.initState();
    getCardDetails();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 190.h,
      width: 380.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(width: 0.4,color: AppColors.white.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 7),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark?[
            AppColors.darkPurple.withOpacity(1),
            AppColors.black.withOpacity(0.3),
            AppColors.darkPurple.withOpacity(0.8),
            AppColors.darkPurple.withOpacity(1),
          ]:
              [   AppColors.lightPurple2.withOpacity(0.8),
                AppColors.white.withOpacity(0.3),
                AppColors.lightPurple2.withOpacity(0.4),
                AppColors.lightPurple2.withOpacity(1),],
          stops: [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      padding: EdgeInsets.only(top: 5.0,bottom: 10.0,left: 20.0,right: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/Icons/card.png',height: 80,width: 80.0,),
            ],),
          SizedBox(height: 5.0,),
          Image.asset('assets/Icons/chip.png',height: 35.0,width: 50.0,color: AppColors.darkPurple,),

          Padding(
            padding: const EdgeInsets.only(top: 15.0,left: 10.0,),
            child: Text(card_num,
            style: TextStyle(
              fontSize: 19.0,
              color: isDark?AppColors.transparent: AppColors.black.withOpacity(0.5),
              fontWeight: FontWeight.w600,
              fontFamily: 'RobotoMono',
              letterSpacing: 0.9,
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 10.0,),
                child: Text(userName,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: isDark ?AppColors.transparent: AppColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                    letterSpacing: 0.9,
                  ),),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,right: 10.0,),
                    child: Text(validate,
                      style: TextStyle(
                        fontSize: 19.0,
                        color: isDark ?AppColors.transparent: AppColors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.9,
                      ),),
                  ),
                  Image.asset('assets/Icons/contactless.png',height: 50.0,color: isDark? AppColors.white.withOpacity(0.5): AppColors.black.withOpacity(0.5),),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
