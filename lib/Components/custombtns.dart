import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import '../Card/Request/Request_Card_Screen.dart';
import '../Widgets/custombtns_widget.dart';
import '../screens/MainScreens/Card_balance screen/Balance_screen.dart';
import '../screens/MainScreens/Recharge/Recharge_Screen.dart';

class Appbtns extends StatefulWidget {
  final bool isLoading;
  const Appbtns({
    Key ? key,
    required this.isLoading
}): super(key: key);

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
          imagePath: 'assets/Icons/add_credit.png',
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
          imagePath: 'assets/Icons/1wallet.png',
          text: 'Balance',
        ),
      ],
    );
  }
}
