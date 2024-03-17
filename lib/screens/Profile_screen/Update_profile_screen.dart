import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/Components/UserIcon.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  String id = '';
  String userName = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  String DOB = '';
  String gender = '';
  bool isLoading = false;
  bool isDark = false;
  var data;
  var logindata;

    Future<void> _updateProfile() async {
      final form = _formKey.currentState;
      if (form!.validate()) {
        setState(() {
          isLoading = true;
        });
        String fullName = fullNameController.text;
        String email = emailController.text;
        String phoneNumber = _phoneNumberController.text;
  
        print('Full Name: $fullName');
        print('Email: $email');
        print('Phone: $phoneNumber');
  
        final login_url = Uri.parse(
            "https://petrocard.000webhostapp.com/API/updateprofile2.php");
        try {
          final response = await http.post(login_url, body: {
            "id": id,
            "name": fullName,
            "email": email,
            "phone": phoneNumber,
          });
  
          if (response.statusCode == 200) {
            logindata = jsonDecode(response.body);
            data = jsonDecode(response.body)['user'];
            print(logindata);
            setState(() {
              isLoading = false;
            });
  
            if (logindata['error'] == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(logindata['message'].toString()),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BaseScreen()),
                    (route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(logindata['message'].toString()),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            // Handle HTTP error responses here
            print('Failed to get response from server.');
          }
        } catch (e) {
          // Handle any exceptions that might occur during the HTTP request
          print('Error occurred during HTTP request: $e');
        }
      }
    }

  Future<void> getUserName() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      id = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      email = setpreference.getString('email') ?? '';
      phone = setpreference.getString('phone') ?? '';
      address = setpreference.getString('address') ?? '';
      DOB = setpreference.getString('dob') ?? '';
      gender = setpreference.getString('gender') ?? '';
      print('id: $id');
      print('name: $userName');
      print('phone : $phone');
      print('email: $email');
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.black : AppColors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(FontAwesomeIcons.angleLeft,
              color: isDark ? AppColors.white : AppColors.black),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
             color: isDark ? Colors.white70 :AppColors.darkPurple,
              fontSize: 20.0,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              icon: Icon(isDark ? FontAwesomeIcons.moon : Icons.sunny,
                  color: isDark ? AppColors.white : AppColors.black))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle
                    ),
                    child: UserIcon(isDark: isDark,),
                  ),
                ),
                SizedBox(
                  height: 30.0.h,
                ),
                ProfileTextfield(
                  validatorValue: (val) {
                    return null;
                  },
                  isDark: isDark,
                  errorMsg: 'Please enter full name',
                  Controller: fullNameController,
                  prefixicon: FontAwesomeIcons.user,
                  hintText: 'Full Name',
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                ProfileTextfield(
                  validatorValue: (val) {
                    if (RegExp(r"\s").hasMatch(val)) {
                      return "Email must not be empty";
                    } else {
                      if (RegExp(r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                          .hasMatch(val)) {
                      }
                    }
                    return null;
                  },
                  isDark: isDark,
                  errorMsg: 'Enter a valid Email',
                  Controller: emailController,
                  prefixicon: FontAwesomeIcons.envelope,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                ProfileTextfield(
                  validatorValue: (val) {
                    if (_phoneNumberController.text.length == 10 && int.tryParse(_phoneNumberController.text) != null){
                      return 'Please Enter 10-digit mobile number.';
                    }
                    return null;
                  },
                  isDark: isDark,
                  errorMsg: 'Please enter full name',
                  Controller: _phoneNumberController,
                  prefixicon: FontAwesomeIcons.mobileScreen,
                  hintText: 'Phone',
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                if(address.isNotEmpty)
                ProfileTextfield(
                  validatorValue: (val) {
                    return null;
                  },
                  isDark: isDark,
                  errorMsg: 'Please enter Address',
                  address: true,
                  Controller: _addressController,
                  prefixicon: FontAwesomeIcons.addressCard,
                  hintText: 'Address',
                ),
                SizedBox(
                  height: 10.0,
                ),
                if(DOB.isNotEmpty)
                ProfileTextfield(
                  validatorValue: (val) {
                    return null;
                  },
                  isDark: isDark,
                  errorMsg: 'Please enter Dob',
                  Controller: _dobController,
                  prefixicon: FontAwesomeIcons.calendar,
                  hintText: 'Dob',
                  issufix: true,
                ),
                SizedBox(
                  height: 40.0.h,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _updateProfile();
                      FocusScope.of(context).unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:isDark ?AppColors.primaryPurple.withOpacity(0.8) : AppColors.darkPurple,
                      side: BorderSide.none,
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: isDark ?Colors.white38: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextfield extends StatelessWidget {
  const ProfileTextfield({
    super.key,
    required this.Controller,
    required this.prefixicon,
    required this.validatorValue,
    required this.errorMsg,
    required this.isDark,
    this.issufix = false,
    this.address = false,
    required this.hintText,
  });

  final TextEditingController Controller;
  final IconData prefixicon;
  final Function(String value) validatorValue;
  final bool address;
  final String errorMsg;
  final bool isDark;
  final bool issufix;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      maxLines: address ? 3 :1,
      textInputAction: TextInputAction.next,
      validator: (value){
        validatorValue(value!);
        if(value.isEmpty){
          return errorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: isDark ? Colors.grey[700]:Colors.grey[200],
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
          prefixIcon:
          address? Padding(padding: EdgeInsets.only(bottom: 30.0),
              child: Icon(
            prefixicon,
            color: isDark ? AppColors.primaryPurple.withOpacity(0.8) : AppColors.darkPurple,
            size: 18.0,
          ),
          ): Icon(
            prefixicon,
            color:isDark ? AppColors.primaryPurple.withOpacity(0.8) : AppColors.darkPurple,
            size: 18.0,
          ),
          suffixIcon: issufix
              ? Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: AppColors.secondaryText,
                )
              : null),
    );
  }
}
