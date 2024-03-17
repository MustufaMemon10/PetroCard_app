import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Card/Recharge/Recharge_Screen.dart';
import 'package:petrocardapppp/screens/MainScreen/Card_balance%20screen/Balance_screen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import '../Card/Request/Request_Card_Screen.dart';
import '../Widgets/custombtns_widget.dart';

class Appbtns extends StatefulWidget {
  const Appbtns({super.key});

  @override
  State<Appbtns> createState() => _AppbtnsState();
}

class _AppbtnsState extends State<Appbtns> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Btn(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RechargeCardScreen(),
              ),
            );
          },
          icon: FontAwesomeIcons.moneyCheck,
          text: 'Recharge',
        ),
        Btn(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BalanceScreen(),
              ),
            );
          },
          icon: FontAwesomeIcons.creditCard,
          text: 'Balance',
        ),
      ],
    );
  }
}
