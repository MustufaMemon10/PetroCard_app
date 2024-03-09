import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/utilities/colors.dart';
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
              children:  [
                btn(icon: FontAwesomeIcons.moneyCheck,text: 'Add Money',),
                btn(icon: FontAwesomeIcons.creditCard,text: 'Balance',),
              ],
            );
  }
}