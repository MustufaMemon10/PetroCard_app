import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:petrocardapppp/Components/custombtns.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cardsfield extends StatefulWidget {
  final String card_num;
  final String userName;
 const Cardsfield({
   required this.card_num,
   required this.userName,
   Key? key}) : super(key: key);

  @override
  State<Cardsfield> createState() => _CardsfieldState();
}

class _CardsfieldState extends State<Cardsfield> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        FadeInDown(
            duration: Duration(milliseconds: 400),
            child: PetroMainCard(card_num: widget.card_num,userName: widget.userName,)),
        SizedBox(height: 20.0,),
        FadeIn(child: Appbtns()),
      ],
    );
  }
}
