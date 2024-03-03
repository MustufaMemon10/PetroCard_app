import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request_Screen extends StatefulWidget {
  const Request_Screen({Key? key}) : super(key: key);

  @override
  State<Request_Screen> createState() => _Request_ScreenState();
}

class _Request_ScreenState extends State<Request_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _selectedGender = '';
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  DateTime? _selectedDate;
  String userName = '';
  String email = '';
  String phone = '';

  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('name') ?? '';
      email = sharedPreferences.getString('email') ?? '';
      phone = sharedPreferences.getString('phone')?? '';
      nameController.text = userName;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Your Card'),
      ),
      body: Container(
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
                  readOnly: true,
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: nameController.text.isNotEmpty ? nameController.text : 'Full name',
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
                        color: AppColors.darkPurple,
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
                        color: AppColors.darkPurple,
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
                        color: AppColors.darkPurple,
                      ),
                      suffixIcon: Icon(Icons.calendar_today,color: AppColors.secondaryText,)
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
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Adress',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0), // R
                        borderSide: BorderSide.none
                    ),
                    filled: true, // Enable filled mode
                    fillColor: Colors.grey[200],
                    hintStyle:
                    const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                    contentPadding: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                    prefixIcon: Icon(Icons.home_work_outlined,
                      color: AppColors.darkPurple,
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
                      color: AppColors.darkPurple,
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
        ),
      ),
    );
  }
}
