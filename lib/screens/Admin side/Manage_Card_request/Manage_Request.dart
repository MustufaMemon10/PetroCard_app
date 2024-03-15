import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:card_loading/card_loading.dart';
import 'package:petrocardapppp/screens/Admin%20side/Components/RequestUserIcon.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:photo_view/photo_view.dart';

class ManageRequestsScreen extends StatefulWidget {
  @override
  _ManageRequestsScreenState createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  List<Map<String, dynamic>> requestData = [];
  String? Gender;
  bool isLoading = false;
  late List<bool> isClicked;

  late List<bool> isAdditionalCardVisibleList;

  String? getGender(int index) {
    if (index >= 0 && index < requestData.length) {
      return requestData[index]['gender'];
    }
    return null;
  }

  Future<void> fetchUserData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/Admin/fetch_cardrequestapi.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          final List<dynamic> RequestsData = responseData['data'];
          setState(() {
            requestData = RequestsData.cast<Map<String, dynamic>>();
            isAdditionalCardVisibleList =
                List.generate(requestData.length, (index) => false);
            isClicked = List.generate(requestData.length, (index) => false);
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
    fetchUserData();
  }

  Future<void> _refreshData() async {
    await fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 0.055.sh),
                      CardLoading(
                        height: 270,
                        width: 1.sw,
                        animationDuration: Duration(seconds: 1),
                        animationDurationTwo: Duration(seconds: 2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      CardLoading(
                        height: 270.0,
                        width: 1.sw,
                        animationDuration: Duration(seconds: 1),
                        animationDurationTwo: Duration(seconds: 2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      CardLoading(
                        height: 200.0,
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
                child: Stack(
                  children: [
                    ListView.builder(
                        itemCount: requestData.length,
                        itemBuilder: (context, index) {
                          final request = requestData[index];
                          final reqDate = DateFormat('dd-MM-yyyy').format(
                              DateTime.parse(requestData[index]['req_date']));
                          final imageUrl =
                              'https://petrocard.000webhostapp.com/${requestData[index]['doc_img']}';
                          return Stack(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  height: 270.0,
                                  width: 1.sw,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.boxShadow
                                              .withOpacity(0.4),
                                          offset: Offset(1, 1)),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 1.sw,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: AppColors.white
                                                .withOpacity(0.7),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RequestUserIcon(
                                                    Gender: getGender(index)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 9.0),
                                                  child: Text(
                                                      '${request['name']}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'RobotoMono')),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isAdditionalCardVisibleList[
                                                              index] =
                                                          !isAdditionalCardVisibleList[
                                                              index];
                                                    });
                                                  },
                                                  child: Text(
                                                    'see more',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0,
                                                        color: AppColors
                                                            .accentColor),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.darkPurple
                                            .withOpacity(0.3),
                                      ),
                                      Container(
                                        width: 1.sw,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: AppColors.white
                                                .withOpacity(0.7),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Date and its value
                                            Container(
                                              width: 0.8.sw,
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Date:',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                  SizedBox(width: 60.0),
                                                  Text(
                                                    '$reqDate',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            // PAN Number and its value
                                            Container(
                                              width: 0.8.sw,
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'PAN Number:',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Text(
                                                    '${request['pan_number']}',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Container(
                                              width: 0.9.sw,
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Address:',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                  SizedBox(width: 30.0),
                                                  Expanded(
                                                    child: Text(
                                                      '${request['address']}',
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryText,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'RobotoMono',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Container(
                                              width: 0.8.sw,
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Image:',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'RobotoMono',
                                                    ),
                                                  ),
                                                  SizedBox(width: 30.0),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isClicked[index] =
                                                            !isClicked[index];
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 20.0.h,
                                                      width: 45.0.w,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .accentColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          width: 0.8,
                                                          color: isClicked[
                                                                  index]
                                                              ? AppColors
                                                                  .accentColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : AppColors
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'show',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 7.0,
                                            right: 15.0,
                                            left: 15.0,
                                            bottom: 7.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 35,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                        width: 0.4.w,
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade50,
                                                        offset:
                                                            Offset(-6, -6),
                                                        blurRadius: 10,
                                                        spreadRadius: 1,
                                                      ),
                                                    ]),
                                                child: Center(
                                                  child: Text(
                                                    '${request['status']}',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Visibility(
                                    visible: isAdditionalCardVisibleList[index],
                                    child: Container(
                                      color: Colors.black.withOpacity(0.1),
                                      padding: EdgeInsets.all(20.0),
                                      child: Stack(
                                        children: [
                                          Card(
                                            elevation: 1,
                                            color: Colors.grey[200],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white
                                                          .withOpacity(0.8),
                                                      border: Border.all(
                                                        color: AppColors.white
                                                            .withOpacity(0.7),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'ID:',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${request['id']}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white
                                                          .withOpacity(0.8),
                                                      border: Border.all(
                                                        color: AppColors.white
                                                            .withOpacity(0.7),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Name:',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${request['name']}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white
                                                          .withOpacity(0.8),
                                                      border: Border.all(
                                                        color: AppColors.white
                                                            .withOpacity(0.7),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Email:',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${request['email']}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white
                                                          .withOpacity(0.8),
                                                      border: Border.all(
                                                        color: AppColors.white
                                                            .withOpacity(0.7),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Phone:',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${request['phone']}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkPurple,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Add more details as needed
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (isAdditionalCardVisibleList[
                                              index])
                                            Positioned(
                                                top: 5.0,
                                                right: 5.0,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isAdditionalCardVisibleList[
                                                            index] = false;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color:
                                                          AppColors.accentColor,
                                                    )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Visibility(
                                  visible: isClicked[index],
                                  child: Stack(
                                    children: [
                                      Container(
                                        color: Colors.black.withOpacity(0.1),
                                        padding: EdgeInsets.all(20.0),
                                        child: Card(
                                          elevation: 1,
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 300,
                                              child: PhotoView(
                                                imageProvider:
                                                    NetworkImage(imageUrl),
                                                loadingBuilder:
                                                    (context, event) => Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (isClicked[index])
                                        Positioned(
                                            top: 10.0,
                                            right: 10.0,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isClicked[index] = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: AppColors.accentColor
                                                      .withBlue(200),
                                                )))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ));
  }
}
