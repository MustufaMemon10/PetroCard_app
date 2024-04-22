import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:petrocardapppp/Card/Request_Card/pending..dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../screens/MainScreens/HomeScreen.dart';
import '../../utilities/colors.dart';

class RequestCardScreen extends StatefulWidget {
  final String userId;

  const RequestCardScreen({Key? key, required this.userId,}) : super(key: key);

  @override
  State<RequestCardScreen> createState() => _RequestCardScreenState();
}

class _RequestCardScreenState extends State<RequestCardScreen> {
  String? status;
  String? reason;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkHasRequested();
  }
  Future<void> _checkHasRequested() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl =
        'https://petrocard.000webhostapp.com/API/checkUserHasRequested.php';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': setpreference.getString('id') ?? ''},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('reason:$reason');
        setpreference.setString('reqStatus',
            responseData['status'].toString());
        setpreference.setString('r_reason',
            responseData['reason'].toString());
        setpreference.setString('gender',
            responseData['gender'].toString());
        setState(() {
          isLoading = false;
          status = setpreference.getString('reqStatus')!;
          reason = setpreference.getString('r_reason')!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch data'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error calling API: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No connection'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
        child: LoadingAnimationWidget.halfTriangleDot(
          color: AppColors.darkPurple,
          size: 50,
        ))
        : Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child:
     status == "pending"
              ? pendingscreen()
     : status == "Accepted"
         ? HomeScreen()
              : status == "rejected"?
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Request Rejected,'),
                reason != null ?Text(reason!, style: TextStyle(color: AppColors.red)) : Text('Reason not provided'),
                TextButton(onPressed: (){const Request_Screen();}, child: Text('Request Again?'))
              ],
            ),
          )
          :TextButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const Request_Screen(),
            ),
          );
        },
        child: Text('REQUEST FOR CARD'),
      )
      ),
    );
  }
}
