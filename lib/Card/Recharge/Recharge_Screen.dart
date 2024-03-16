import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class RechargeCardScreen extends StatefulWidget {
  const RechargeCardScreen({super.key});

  @override
  State<RechargeCardScreen> createState() => _RechargeCardScreenState();
}

class _RechargeCardScreenState extends State<RechargeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge Card',style:TextStyle(
          fontWeight: FontWeight.w700,fontSize: 18.0,color: AppColors.black,
        ),),
        centerTitle: true,
      ),
      body: Column(

      ),
    );
  }
}
