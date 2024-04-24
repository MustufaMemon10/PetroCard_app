import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/Card/Request/Request_Card_Screen.dart';
import 'package:petrocardapppp/Card/Request_Card/pending..dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../screens/MainScreens/HomeScreen.dart';
import '../../utilities/colors.dart';

class RequestCardScreen extends StatefulWidget {
  final String userId;

  const RequestCardScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<RequestCardScreen> createState() => _RequestCardScreenState();
}

class _RequestCardScreenState extends State<RequestCardScreen> {
  String? status;
  String reason = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkHasRequested();
  }
  Future<void> _refreshData() async {
    await _checkHasRequested();
  }

  Future<void> _checkHasRequested() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl =
        'https://petrocard.000webhostapp.com/API/checkUserHasRequested.php';
    try {
      setState(() {
        isLoading = true;
      });
      print(setpreference.getString('req_id'));
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': setpreference.getString('id') ?? '',
      'req_id': setpreference.getString('req_id'),
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setpreference.setString('reqStatus', responseData['status'].toString());
        setpreference.setString('reason', responseData['r_reason'].toString());
        setpreference.setString('gender', responseData['gender'].toString());
        setState(() {
          isLoading = false;
          status = setpreference.getString('reqStatus')!;
          reason = setpreference.getString('reason')!;
        });
        print('reason:$reason');
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
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        displacement: kToolbarHeight + 20.0,
        color: AppColors.black,
        backgroundColor: AppColors.white,
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                color: AppColors.darkPurple,
                size: 50,
              ))
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                    child: status == "pending"
                        ? pendingscreen()
                        : status == "Approved"
                            ? HomeScreen()
                            : status == "rejected"
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Request Rejected,',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                                            reason == 'other'
                                                ? Text('Reason not provided')
                                                : Text(reason,
                                                    style: TextStyle(
                                                        color: AppColors.red,fontWeight: FontWeight.w500,fontSize: 14.0)),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          Request_Screen()));
                                            },
                                            child: Text('Request Again?',style: TextStyle(
                                                color: AppColors.accentColor,fontWeight: FontWeight.w700,fontSize: 16.0)))
                                      ],
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const Request_Screen(),
                                        ),
                                      );
                                    },
                                    child: Text('REQUEST FOR CARD'),
                                  )),
              ),
      ),
    );
  }
}
