import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:petrocardapppp/screens/Admin%20side/Assign_Card/Card.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class AssignCardScreen extends StatefulWidget {
  String userName = '';
  AssignCardScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _AssignCardScreenState createState() => _AssignCardScreenState();
}

class _AssignCardScreenState extends State<AssignCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedOption = '';
  String textFieldValue = '';
  TextEditingController cardNumController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: AppColors.darkPurple,
          ),
          iconSize: 18.0,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0.h),Container(
          height: 0.270.sh,
          width: 380.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r),
            border: Border.all(
                width: 0.4, color: AppColors.white.withOpacity(0.7)),
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
              colors:  [
                AppColors.darkPurple.withOpacity(1),
                AppColors.darkPurple.withOpacity(0.3),
              ],
              stops: [0.0, 1.0],
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
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
              Padding(
                padding:  EdgeInsets.only(bottom: 12.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/Icons/chip (2).png',
                      height: 35.0.h,
                      width: 50.0.h,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 8.0.w),
                      child: Image.asset(
                        'assets/Icons/contactless.png',
                        height: 35.0.h,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: cardNumController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                      ),
                      ),
                      style: TextStyle(
                        fontSize: 19.0.sp,
                        color:AppColors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.9,
                      ),
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 19.0.sp,
                        color:
                        AppColors.white.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.9,
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
              // Cardfield(card_num: cardNumController.text, userName: userNameController.text),
              SizedBox(height: 10.0.h),
              Divider(),
              SizedBox(
                height: 0.05.sh,
              ),
              TextFormField(
                  controller: cardNumController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {},
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
                        color: AppColors.secondaryText, letterSpacing: 0.7),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
                        color: AppColors.primaryText, letterSpacing: 0.7),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    prefixIcon: Icon(
                      FontAwesomeIcons.creditCard,
                      color: AppColors.darkPurple,
                      size: 18.0,
                    ),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
