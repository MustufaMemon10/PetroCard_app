import 'package:flutter/material.dart';
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
                btn(containerColor: AppColors.white.withOpacity(0.8), icon: Icons.add_card_outlined,btntext: 'Add Money'),
                btn(containerColor: AppColors.white.withOpacity(0.8), icon: Icons.account_balance_wallet_outlined,btntext: 'Balance'),
              ],
            );
  }
}