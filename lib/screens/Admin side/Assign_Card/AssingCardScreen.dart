import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class AssignCardScreen extends StatefulWidget {
  final String userName;
  final String req_id;

  AssignCardScreen({Key? key, required this.userName, required this.req_id})
      : super(key: key);

  @override
  _AssignCardScreenState createState() => _AssignCardScreenState();
}

class _AssignCardScreenState extends State<AssignCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedOption = '';
  String textFieldValue = '';
  bool isLoading = false;
  TextEditingController cardNumController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController requestIdController = TextEditingController();

  Future<void> _assignCard() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      print('userName: ${widget.userName}');
      print('req_id: ${widget.req_id}');
      setState(() {
        isLoading = true;
      });
      final apiUrl =
          'https://petrocard.000webhostapp.com/API/Admin/assigncardnumber.php';
      try {
        setState(() {
          isLoading = true;
        });
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            "card_num": cardNumController.text,
            "req_id": widget.req_id,
          },
        );
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setState(() {
            isLoading = false;
          });
          if (!responseData['error']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseData['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green, // Customize background color
              ),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(responseData['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red, // Customize background color
              ),
            );
          }
        } else {
          print('Failed to fetch user data: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Assign Card',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: AppColors.darkPurple),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          ),
          iconSize: 18.0,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
            child: LoadingAnimationWidget.halfTriangleDot(
                color: AppColors.darkPurple,
                // leftDotColor: AppColors.darkPurple,
                // rightDotColor: AppColors.white,
                size: 50,
              ),
          )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0.h),
                    Container(
                      height: 0.270.sh,
                      width: 380.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        border: Border.all(
                            width: 0.4,
                            color: AppColors.white.withOpacity(0.7)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 10,
                            blurRadius: 7,
                            offset: Offset(0, 7),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.darkPurple.withOpacity(1),
                            AppColors.darkPurple.withOpacity(0.3),
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 10.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/Icons/card.png',
                                height: 80,
                                width: 80.0,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/Icons/chip (2).png',
                                height: 35.0.h,
                                width: 50.0.h,
                                color: Colors.white70,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.0.w),
                                child: Image.asset(
                                  'assets/Icons/contactless.png',
                                  height: 50.0.h,
                                  color: AppColors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:40,
                                  child: TextField(
                                    controller: cardNumController,
                                    readOnly:  true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    style: TextStyle(
                                      fontSize: 19.0.sp,
                                      color: AppColors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'RobotoMono',
                                      letterSpacing: 0.9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: Text(
                                    widget.userName,
                                    style: TextStyle(
                                      fontSize: 19.0.sp,                                    color: AppColors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'RobotoMono',
                                      letterSpacing: 0.9,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    TextFormField(
                        controller: cardNumController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null && value!.isEmpty) {
                            return 'Card Number is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Card Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkPurple),
                            // Customize focused border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red),
                            // Customize error border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: const TextStyle(
                              color: AppColors.secondaryText,
                              letterSpacing: 0.7),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: AppColors.darkPurple,
                            size: 18.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                        controller: userNameController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        enabled: false,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: widget.userName,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkPurple),
                            // Customize focused border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red),
                            // Customize error border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: const TextStyle(
                              color: AppColors.primaryText, letterSpacing: 0.7),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: AppColors.darkPurple,
                            size: 18.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                        controller: requestIdController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: widget.req_id,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red),
                            // Customize error border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: const TextStyle(
                              color: AppColors.primaryText, letterSpacing: 0.7),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: AppColors.darkPurple,
                            size: 18.0,
                          ),
                        )),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: 250.w,
                        height: 40.h,
                        child: ElevatedButton(
                            onPressed: () {
                              _assignCard();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.darkPurple,
                              side: BorderSide.none,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              'Assign',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
