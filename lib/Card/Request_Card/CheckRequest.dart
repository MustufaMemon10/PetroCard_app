import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:petrocardapppp/Card/Request_Card/pending..dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utilities/colors.dart';

class RequestCardScreen extends StatefulWidget {
  final String userId;

  const RequestCardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<RequestCardScreen> createState() => _RequestCardScreenState();
}

class _RequestCardScreenState extends State<RequestCardScreen> {
  String? status;
  bool isLoading = false;

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
        body: {'id': setpreference.getString('id') ?? ''}, // Use userId here
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        setpreference.setString('reqStatus',
            responseData['status'].toString()); //
        setpreference.setString('gender',
            responseData['gender'].toString()); // Set the actual status
        setState(() {
          isLoading = false;
          status = setpreference.getString('reqStatus')!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch data'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Customize background color
          ),
        );
      }
    } catch (error) {
      print('Error calling API: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error calling API'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child:
      isLoading
          ? Center(
              child: LoadingAnimationWidget.halfTriangleDot(
              color: AppColors.darkPurple,
              size: 50,
            ))
          : status == "pending"
              ? pendingscreen()
              : status == "Rejected"?
          Text('Request Rejected')
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
