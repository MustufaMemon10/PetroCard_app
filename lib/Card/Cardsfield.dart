import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/custombtns.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/custombtns_widget.dart';
import '../screens/MainScreen/Card_balance screen/Balance_screen.dart';
import '../utilities/colors.dart';
import 'Request/Request_Card_Screen.dart';

class Cardsfield extends StatefulWidget {
  Cardsfield({Key? key}) : super(key: key);

  @override
  State<Cardsfield> createState() => _CardsfieldState();
}

class _CardsfieldState extends State<Cardsfield> {
  bool _showAddCardButton = true;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.12.sh),
        PetroMainCard(),
        SizedBox(height: 20.0.h,),
        Appbtns(),
      ],
    );
  }
}
