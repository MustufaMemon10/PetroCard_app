import 'dart:convert';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request_Screen extends StatefulWidget {
  const Request_Screen({Key? key}) : super(key: key);

  @override
  State<Request_Screen> createState() => _Request_ScreenState();
}

class _Request_ScreenState extends State<Request_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _selectedGender = '';
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  String? _panPhotoPath;
  bool _imageSelected = false;
  var user_id;
  var logindata;
  var data;
  DateTime? _selectedDate;
  bool _isLoading = false;
  bool isLoading = false;
  bool isSuccess = false;
  String email = '';
  String phone = '';

  Future<void> _handleApplication() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url =
          Uri.parse("https://petrocard.000webhostapp.com/API/apply_card.php");
      final response = await http.post(login_url, body: {
        "doc_img": _panPhotoPath,
        "status": 'pending',
        "address": _addressController.text,
        "gender": _selectedGender,
        "dob": _dobController.text,
        "pan_number": panNumberController.text,
        "id": user_id,
      });

      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = jsonDecode(response.body)['user'];
        print(logindata);
        setState(() {
          isLoading = false;
          isSuccess = true;
        });
        if (logindata['error'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BaseScreen()),
              (route) => false);
        } else {
          print('address: $_addressController.text');
          print('gender: $_selectedGender');
          print('dob: $_dobController.text');
          print('pan_number: $panNumberController');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      }
    }
  }

  getUserData() async {
    SharedPreferences sharedPreferences;
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        user_id = sharedPreferences.getString('id') ?? '';
        email = sharedPreferences.getString('email') ?? '';
        phone = sharedPreferences.getString('phone') ?? '';
        String name = sharedPreferences.getString('name') ?? '';
        _emailController.text = email;
        _phoneNumberController.text = phone;

        print('User ID: $user_id');
        print('Email: $email');
        print('Phone: $phone');
        print('Name: $name');
      });
    } catch (e) {
      print('Error fetching SharedPreferences: $e');
      return;
    }
  }

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  // getUserData() async {
  //   SharedPreferences setpreference = await SharedPreferences.getInstance();
  //   setState(() {
  //     user_id = setpreference.getString('id')!;
  //     email = setpreference.getString('email')!;
  //     phone = setpreference.getString('phone')!;
  //     _emailController.text = email;
  //     _phoneNumberController.text = phone;
  //   });
  // }
  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.year}/${picked.month}/${picked.day}";
        print('DOB : $_dobController.text');
      });
    }
  }

  Future<void> _pickPhoto() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(
        source:
            _panPhotoPath != null ? ImageSource.gallery : ImageSource.camera,
      );
      if (pickedFile != null) {
        setState(() {
          _panPhotoPath = pickedFile.path;
          _imageSelected = true;
          print('panphoto: $_panPhotoPath');
        });
      }
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Permission Required"),
          content: Text("Please grant access to the storage to upload photos."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else if (status == PermissionStatus.permanentlyDenied) {
      // Show a dialog indicating that permission is permanently denied
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Permission Denied"),
          content:
              Text("Please enable access to the storage in the app settings."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  String? validateUPI(String? value) {
    if (value == null || value.isEmpty) {
      return 'UPI ID is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.darkPurple,
                rightDotColor: AppColors.accent2Turquoise,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.10.sh,
                          ),
                          Text(
                            "Apply Your Card",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Enjoy Quick Payments",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.0,
                              color: AppColors.darkPurple,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                    width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              controller: panNumberController,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                hintText: 'Enter PAN number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                // Enable filled mode
                                fillColor: Colors.grey[200],
                                hintStyle: const TextStyle(
                                    color: AppColors.secondaryText,
                                    letterSpacing: 0.7),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.user,
                                  color: AppColors.darkPurple,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                    width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (val) {
                                if (RegExp(r"\s").hasMatch(val!) ||
                                    val.isEmpty) {
                                  return "Email must not be empty";
                                } else {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                      .hasMatch(val)) {}
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: _emailController.text,
                                hintStyle: const TextStyle(
                                    color: AppColors.secondaryText,
                                    letterSpacing: 0.7),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0), // R
                                    borderSide: BorderSide.none),
                                filled: true,
                                // Enable filled mode
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.darkPurple,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'DOB is Required';
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: _dobController,
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: InputDecoration(
                                hintText: 'DOB',
                                hintStyle: const TextStyle(
                                    color: AppColors.secondaryText,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0), // R
                                    borderSide: BorderSide.none),
                                filled: true,
                                // Enable filled mode
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.darkPurple,
                                  size: 18.0,
                                ),
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: AppColors.secondaryText,
                                  size: 18.0,
                                )),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.go,
                            controller: _addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address is Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              // Enable filled mode
                              fillColor: Colors.grey[200],
                              hintStyle: const TextStyle(
                                  color: AppColors.secondaryText,
                                  letterSpacing: 0.7),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              prefixIcon: Icon(
                                Icons.home_work_outlined,
                                color: AppColors.darkPurple,
                                size: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number is Required';
                              }
                              return null;
                            },
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: _phoneNumberController.text.isNotEmpty
                                  ? _phoneNumberController.text
                                  : 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(20.0), // R
                                  borderSide: BorderSide.none),
                              filled: true,
                              // Enable filled mode
                              fillColor: Colors.grey[200],
                              hintStyle: const TextStyle(
                                  color: AppColors.secondaryText,
                                  letterSpacing: 0.7),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              prefixIcon: Icon(
                                CupertinoIcons.phone,
                                color: AppColors.darkPurple,
                                size: 18.0.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Gender :",
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Radio(
                                  value: 'Male',
                                  activeColor: AppColors.darkPurple,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Male',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Radio(
                                  value: 'Female',
                                  activeColor: AppColors.darkPurple,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Female',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Radio(
                                  value: 'Helicopter',
                                  activeColor: AppColors.darkPurple,
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Helicopter',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Option:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0.h, horizontal: 5.0.w),
                                child: Text(
                                  'Your UPI Id',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: upiIdController,
                                validator: validateUPI,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintStyle: const TextStyle(
                                      color: AppColors.secondaryText,
                                      letterSpacing: 0.7),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  labelText: 'Enter UPI Id',
                                  floatingLabelStyle:
                                      TextStyle(color: AppColors.darkPurple),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none),
                                  suffix: _isLoading
                                      ? SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.blue,
                                            ),
                                            strokeWidth: 1.5,
                                            color: AppColors.accentColor,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isLoading = !_isLoading;
                                            });
                                          },
                                          child: Text(
                                            'Verify',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.accentColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _imageSelected
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Uploaded Successfully",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4.0.w,
                                          ),
                                          Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Add your PAN',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0)),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            _pickPhoto();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 60.w,
                                            decoration: BoxDecoration(
                                                color: AppColors.darkPurple,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: Center(
                                              child: Text(
                                                'Upload',
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0.sp),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _handleApplication();
                                },
                                splashColor:
                                    AppColors.accentColor.withOpacity(0.2),
                                child: Center(
                                  child: Container(
                                    height: 35.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.darkPurple,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
    );
  }
}
