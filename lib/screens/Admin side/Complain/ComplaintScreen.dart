import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:petrocardapppp/utilities/colors.dart';
import 'dart:convert';
import 'package:card_loading/card_loading.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = false;

  Future<void> fetchComplaintData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/fetchallcomplaint.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          final List<dynamic> complaindata = responseData['complaints'];
          setState(() {
            userData = complaindata.cast<Map<String, dynamic>>();
          });
          setState(() {
            isLoading = false;
          });
        } else {
          print('Error fetching user data: ${responseData['message']}');
        }
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComplaintData();
  }

  Future<void> _refreshData() async {
    await fetchComplaintData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              margin:
                  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 0.050.sh),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardLoading(
                      height: 100.0,
                      width: 1.sw,
                      animationDuration: Duration(seconds: 1),
                      animationDurationTwo: Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: _refreshData,
              color: AppColors.black,
              backgroundColor: AppColors.white,
              child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  final user = userData[index];
                  return Container(
                    height: 100.0,
                    width: 1.sw,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 10.0, bottom: 10.0),
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor:
                                        AppColors.darkPurple.withOpacity(0.1),
                                    child: Image.asset(
                                      'assets/Icons/man2.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 10.0,
                                            left: 10.0,
                                          ),
                                          child: Text(
                                            '${user['name']}',
                                            style: TextStyle(
                                              fontFamily: 'RobotoMono',
                                              color: AppColors.primaryText,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Text(
                                        '${user['email']}',
                                        style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Text(
                                        'Date: ${user['time']}',
                                        style: TextStyle(
                                            color: AppColors.secondaryText
                                                .withOpacity(0.8),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Text(
                                'Message: ${user['message']}',
                                style: TextStyle(
                                    color: AppColors.secondaryText
                                        .withOpacity(0.8),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5,
                          right: 10,
                          child: Text(
                            'Id: ${user['id']}',
                            style: TextStyle(
                                color: AppColors.secondaryText.withOpacity(0.8),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
