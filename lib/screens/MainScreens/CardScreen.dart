import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Card/MainCard.dart';
import '../../utilities/colors.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool isDark = false;
  String userName = '';
  String email = '';
  String card_num = '';
  String card_id = '';
  String balance = '';
  String status = '';
  String userId = '';
  bool switchValue = true;
  bool isLoading = false;

  void handleSwitchChanged(bool value) async {
    setState(() {
      switchValue = value;
    });
    // Call your API function here based on the switch value
    if (switchValue) {
      await updateCardStatus(userId, 'Active');
    } else {
      await updateCardStatus(userId, 'Inactive');
    }
  }

  Future<void> updateCardStatus(String id, String status) async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    final apiUrl =
        'https://petrocard.000webhostapp.com/API/changecardstatus.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"id": id,
        "status" : status,
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message'].toString()),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      setpreference.setString('status', status);
      await getCardDetails();
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(['message'].toString()),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userId = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
      card_id = setpreference.getString('card_id') ?? '';
      status = setpreference.getString('status') ?? '';
      switchValue = status == 'Active' ? true : false;
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Card',
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              PetroMainCard(
                card_num: card_num,
                userName: userName,
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white.withAlpha(20)),
                  child: Icon(
                    FontAwesomeIcons.creditCard,
                    color: AppColors.darkPurple,
                  ),
                ),
                title: Text(
                  card_num,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white.withAlpha(20)),
                  child: Icon(
                    FontAwesomeIcons.userCheck,
                    color: AppColors.darkPurple,
                  ),
                ),
                title: Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white.withAlpha(20)),
                  child: Icon(
                    FontAwesomeIcons.envelope,
                    color: AppColors.darkPurple,
                  ),
                ),
                title: Text(
                  email,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    letterSpacing: 0.8,
                  ),
                ),
              ),

                  ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.white.withAlpha(20)),
                        child: Icon(
                          FontAwesomeIcons.creativeCommonsSampling,
                          color: AppColors.darkPurple,
                        ),
                      ),
                      title: Text(
                        status,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.black,
                          letterSpacing: 0.8,
                        ),
                      ),
                      trailing: status != 'Blocked'?Switch(
                        value: switchValue,
                        onChanged: handleSwitchChanged,
                        activeColor: AppColors.green,
                        inactiveThumbColor: AppColors.red,
                        inactiveTrackColor: AppColors.red.withOpacity(0.3),
                        activeTrackColor: AppColors.green.withOpacity(0.3),
                      ):  SizedBox(),
                    ),
              status == 'Active' || status == 'Inactive' ?
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white.withAlpha(20)),
                  child: Icon(
                    Icons.block,
                    color: AppColors.darkPurple,
                  ),
                ),
                title: Text(
                      'Block card',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    letterSpacing: 0.8,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showBlockingReasonDialog(context, card_id);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.translightPurple2.withOpacity(0.1)),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColors.translightPurple2,
                      )),
                ),
              ):
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white.withAlpha(20)),
                  child: Icon(
                    Icons.block,
                    color: AppColors.darkPurple,
                  ),
                ),
                title: Text(
                  'Unblock card',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    letterSpacing: 0.8,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title:  Text('Are you sure? You want to Unblock your Card',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(
                                      false); // Return false when cancel is pressed
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: AppColors
                                          .darkPurple.withOpacity(0.9),letterSpacing: .7),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  updateCardStatus(userId, 'Active');
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Unblock",
                                  style: TextStyle(
                                      color: AppColors
                                          .darkPurple,letterSpacing: 0.6),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          AppColors.translightPurple2.withOpacity(0.1)),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColors.translightPurple2,
                      )),
                ),
              )
            ]),
          ),
          Positioned.fill(
            child: isLoading
                ? Container(
                    color: AppColors.white.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.halfTriangleDot(
                          color: AppColors.darkPurple, size: 50),
                    ))
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  List<String> blockingReasons = [
    'Lost card',
    'Stolen card',
    'Suspected fraud',
    'Card not working',
    'Other',
  ];

  void showBlockingReasonDialog(BuildContext context, String card_id) {
    String selectedReason = blockingReasons[0]; // Default to the first reason
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Blocking Reason'),
          content: DropdownButtonFormField(
              value: selectedReason,
              items: blockingReasons.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(
                    reason,
                    style: TextStyle(color: AppColors.black),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedReason = newValue.toString();
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.white70,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        AppColors.darkPurple, // Customize focused border color
                  ),
                ),
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.black.withOpacity(0.6)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('Selected Blocking Reason: $selectedReason');
                _blockreason(card_id, selectedReason);
              },
              child: Text(
                'Block',
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _blockreason(String card_id, String selectedReason) async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl = 'https://petrocard.000webhostapp.com/API/blockcard.php';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "card_id": card_id,
          "b_reason": selectedReason,
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (!responseData['error']) {
          setpreference.setString('status', 'Blocked');
          await getCardDetails();
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
