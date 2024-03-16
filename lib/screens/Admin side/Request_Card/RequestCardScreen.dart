import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/ApiHelper.dart';

class RequestCardScreen extends StatefulWidget {
  const RequestCardScreen({super.key});

  @override
  State<RequestCardScreen> createState() => _RequestCardScreenState();
}

class _RequestCardScreenState extends State<RequestCardScreen> {
  bool hasRequested = false;
  String userId = '';
  Future<void> checkHasRequested(String id) async {
    bool requestStatus = await ApiHelper.checkRequested(userId);
    setState(() {
      hasRequested = requestStatus;
    });
  }
  Future<void> getId() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userId = setpreference.getString('id') ?? '';
    });
    await checkHasRequested(userId);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
              const Request_Screen(),
            ),
          );
        },
          child:Text('REQUEST FOR CARD')
      )
    );
  }
}

