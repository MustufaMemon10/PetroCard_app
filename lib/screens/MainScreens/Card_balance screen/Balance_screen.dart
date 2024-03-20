import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String id = '';
  String userName = '';
  String? balance;

  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      id = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      balance = setpreference.getString('balance') ?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    getCardDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Balance',style: TextStyle(color: AppColors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios_new, color:Colors.black, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your Balance is:',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30.0),),
            Text('${balance ?? "N/A"}',
              style: TextStyle(fontSize: 28.0),
            ),
          ],
        ),
      ),
    );
  }
}
