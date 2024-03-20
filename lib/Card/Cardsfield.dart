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
  String validate = '';

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
    return Column(
      children: [
        SizedBox(height: 105),
        PetroMainCard(userName: userName,card_num: card_num,),
        SizedBox(height: 30.0,),
        isLoading ?Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      CardLoading(height: 50,width: 50,borderRadius: BorderRadius.circular(16),),
      CardLoading(height: 50,width: 50,borderRadius: BorderRadius.circular(16),),
    ],
    ):
        Appbtns(isLoading: isLoading,),
      ],
    );
  }
}
