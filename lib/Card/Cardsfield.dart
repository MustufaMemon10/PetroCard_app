import 'package:animate_do/animate_do.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:petrocardapppp/Components/custombtns.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cardsfield extends StatefulWidget {
 const Cardsfield({
   Key? key}) : super(key: key);

  @override
  State<Cardsfield> createState() => _CardsfieldState();
}

class _CardsfieldState extends State<Cardsfield> {
  bool isLoading = false;
  String userName = '';
  String email = '';
  String card_num = '';

  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    getCardDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 105),
        FadeInDown(
            duration: Duration(milliseconds: 400),
            child: PetroMainCard(card_num: card_num,userName: userName,)),
        SizedBox(height: 30.0,),
        FadeIn(child: Appbtns()),
      ],
    );
  }
}
