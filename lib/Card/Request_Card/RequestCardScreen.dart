import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/API/ApiHelper.dart';

class RequestCardScreen extends StatefulWidget {
  const RequestCardScreen({Key? key}) : super(key: key);

  @override
  State<RequestCardScreen> createState() => _RequestCardScreenState();
}

class _RequestCardScreenState extends State<RequestCardScreen> {
  bool hasRequested = false;
  String userId = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _getId() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userId = setpreference.getString('id') ?? '';
    });
    await _checkHasRequested(userId);
  }

  Future<void> _checkHasRequested(String id) async {
    bool requestStatus = await ApiHelper.checkRequested(userId);
    setState(() {
      hasRequested = requestStatus;
    });
    await _getStatus();
  }

  Future<void> _getStatus() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      status = setpreference.getString('reqStatus') ?? '';
    });
  }
  Future<void> _fetchData() async {
    try {
      await _getId();
      await _checkHasRequested(userId);
      await _getStatus();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return

      Center(
        child:status == 'pending'
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Icons/expired.png'),
            const SizedBox(height: 20),
            Text('Request is pending. We will inform you.'),
          ],
        ): status == ''
            ?TextButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const Request_Screen(),
              ),
            );
          },
          child: Text('REQUEST FOR CARD'),
        ): null,
      );
  }
}
