import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request_Screen extends StatefulWidget {
  const Request_Screen({Key? key}) : super(key: key);

  @override
  State<Request_Screen> createState() => _Request_ScreenState();
}

class _Request_ScreenState extends State<Request_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController panNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _selectedGender = '';
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  String? _panPhotoPath;
  DateTime? _selectedDate;
  bool _isLoading = false;
  String email = '';
  String phone = '';

  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString('email') ?? '';
      phone = sharedPreferences.getString('phone')?? '';
      _emailController.text = email;
      _phoneNumberController.text = phone;

    });
  }
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
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  Future<void> _pickPhoto() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(
        source: _panPhotoPath != null ? ImageSource.gallery : ImageSource.camera,
      );
      if (pickedFile != null) {
        setState(() {
          _panPhotoPath = pickedFile.path;
        });
      }
    } else if (status == PermissionStatus.denied || status == PermissionStatus.restricted) {
      // Show a dialog or message indicating that permission is required
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
      // Show a dialog or message indicating that permission is permanently denied
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Permission Denied"),
          content: Text("Please enable access to the storage in the app settings."),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 0.10.sh,),
              InkWell(
                onTap:(){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apply Your Card",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            "Enjoy Quick Payments",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.0,
                              color: AppColors.darkPurple,
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              controller: panNameController,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                hintText:  'Full name as per PAN',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none
                                ),
                                filled: true, // Enable filled mode
                                fillColor: Colors.grey[200],
                                hintStyle:
                                const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                                contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                                prefixIcon: Icon(FontAwesomeIcons.user,
                                  color: AppColors.darkPurple,size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              readOnly: true,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: _emailController.text.isNotEmpty ? _emailController.text : 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0), // R
                                    borderSide: BorderSide.none
                                ),
                                filled: true, // Enable filled mode
                                fillColor: Colors.grey[200],
                                hintStyle:
                                const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                                contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                                prefixIcon: Icon(Icons.email_outlined,
                                  color: AppColors.darkPurple,size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              controller: _dobController,
                              onTap: () {
                                _selectDate(context); // Open calendar picker on tap
                              },
                              decoration: InputDecoration(
                                  hintText: 'DOB',
                                  hintStyle:
                                  const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.2,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0), // R
                                      borderSide: BorderSide.none
                                  ),
                                  filled: true, // Enable filled mode
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.symmetric(vertical:15.0, horizontal: 20.0),
                                  prefixIcon: Icon(Icons.calendar_month,
                                    color: AppColors.darkPurple,size: 18.0,
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today,color: AppColors.secondaryText,size: 18.0,)
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              textInputAction: TextInputAction.go,
                              controller: _addressController,
                              decoration: InputDecoration(
                                hintText: 'Address',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none
                                ),
                                filled: true, // Enable filled mode
                                fillColor: Colors.grey[200],
                                hintStyle:
                                const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                                contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                                prefixIcon: Icon(Icons.home_work_outlined,
                                  color: AppColors.darkPurple,size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            height: 40.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(width: 1.0, color: AppColors.lightPurple)),
                            child: TextFormField(
                              readOnly: true,
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0), // R
                                    borderSide: BorderSide.none
                                ),
                                filled: true, // Enable filled mode
                                fillColor: Colors.grey[200],
                                hintStyle:
                                const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                                contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                                prefixIcon: Icon(CupertinoIcons.phone,
                                  color: AppColors.darkPurple,size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text("Gender"),
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
                                Text('Male'),
                                Radio(
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Female'),
                                Radio(
                                  value: 'Helicopter',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Helicopter🚁'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Option:',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize:24.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                                child: Text(
                                  'Your UPI Id',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize:20.0),
                                ),
                              ),

                              SizedBox(height: 10),
                              TextFormField(
                                controller: upiIdController,
                                validator: (value) {
                                  RegExp upiRegex = RegExp(
                                      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                  if (!upiRegex.hasMatch(value!)) {
                                    return 'Enter a valid UPI ID';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintStyle:
                                  const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                                  contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                                  labelText: 'Enter UPI Id',
                                  floatingLabelStyle: TextStyle(color: AppColors.darkPurple),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none
                                  ),
                                  suffix: _isLoading? SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
                                      strokeWidth: 1.5,
                                      color: AppColors.accentColor,
                                    ),
                                  ): InkWell(
                                    onTap: (){
                                      setState(() {
                                        _isLoading = !_isLoading;
                                      });
                                    },
                                    child: Text('Verify',style: TextStyle(
                                        fontSize: 12.0,color: AppColors.accentColor,fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add your PAN',style: TextStyle(
                                      color: AppColors.black,fontWeight: FontWeight.w700,fontSize: 16.0
                                  )),
                                  SizedBox(width: 15.0,),
                                  InkWell(onTap: (){
                                    FocusScope.of(context).unfocus();
                                    _pickPhoto();
                                  },
                                    child: Container(
                                      height: 35,
                                      width: 60,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.darkPurple,
                                        borderRadius: BorderRadius.circular(28.0),
                                      ),
                                      child: Center(
                                        child: Text('Upload',style: TextStyle(
                                            color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 14.0
                                        ),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: (){
                                  FocusScope.of(context).unfocus();
                                },
                                splashColor: AppColors.accentColor.withOpacity(0.2),
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
                        ]
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}