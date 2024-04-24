import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petrocardapppp/Card/Request/confirmation.dart';
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
  DateTime? _selectedDate;
  bool isLoading = false;
  var logindata;
  var data;
  String id = '';
  String email = '';
  String name = '';
  String phone = '';
  String? req_id;
  bool imageUploaded = false;

  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString('id') ?? '';
      email = sharedPreferences.getString('email') ?? '';
      name = sharedPreferences.getString('name') ?? '';
      phone = sharedPreferences.getString('phone') ?? '';
      _emailController.text = email;
      _phoneNumberController.text = phone;
    });
  }

  uploadImageMedia(File fileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    final mimeTypeData =
        lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest = http.MultipartRequest('POST',
        Uri.parse("https://petrocard.000webhostapp.com/API/apply_card.php"));

    final file = await http.MultipartFile.fromPath('doc_img', fileImage.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    imageUploadRequest.fields['id'] = prefs.getString('id')!;
    imageUploadRequest.fields['address'] = _addressController.text;
    imageUploadRequest.fields['dob'] = _dobController.text;
    imageUploadRequest.fields['gender'] = _selectedGender;
    imageUploadRequest.fields['pan_number'] = panNumberController.text;
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        if (streamedResponse.statusCode == 200) {
          logindata = jsonDecode(value);
          data = jsonDecode(value)['user'];
          print(logindata);

          if (logindata['error'] == false) {
            setpreference.setString('gender', _selectedGender);
            setpreference.setString('address', _addressController.text);
            setpreference.setString('dob', _dobController.text);
            setpreference.setString('req_id', logindata['req_id']);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logindata['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            setState(() {
              req_id = setpreference.getString('req_id');
              isLoading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => ConfirmationAnimation()),
                (route) => false);
          } else if(logindata['error'] == true) {
            setpreference.setString('req_id', logindata['req_id']);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logindata['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red, // Customize background color
              ),
            );
            setState(() {
              isLoading = false;
            });
          }
          print(streamedResponse.stream);
          print(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          print(value);
        }
      });
    } catch (e) {
      print(e);
      setpreference.setString('req_id', logindata['req_id']);
      setState(() {
        isLoading = false;
      });
    }
  }

  //
  @override
  void initState() {
    getUserName();
    super.initState();
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
        _dobController.text = "${picked.year}/${picked.month}/${picked.day}";
        if (!_isAgeValid(picked)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You must be at least 18 years old.'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  bool _isAgeValid(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age >= 18;
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      imageUploaded = true;
    });
  }

  bool _validateForm() {
    if (panNumberController.text.isEmpty || _addressController.text.isEmpty || _dobController.text.isEmpty ||_selectedGender.isEmpty || _image == null || _image!.path.isEmpty ) {
      return false;
    }
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(children: [
                    SizedBox(height: 50.0,),
                    ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    InkWell(
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
                                FadeInUp(
                                  duration: Duration(milliseconds: 190),
                                  child: Text(
                                    "Elevate your Payment experience",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 210),
                                  child: Text(
                                    "with our feature-rich Petro Card.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0,
                                      color: AppColors.darkPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 230),
                                  child: TextFormField(
                                      controller: panNumberController,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
                                            .hasMatch(value!)) {
                                          return 'Please enter a valid PAN Number';
                                        }
                                        if (value.isEmpty) {
                                          return 'PAN Number is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'PAN Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                                width: 0.5)),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.darkPurple),
                                          // Customize focused border color
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.red),
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
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 250),
                                  child: TextFormField(
                                      controller: _emailController,
                                      readOnly: true,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: _emailController.text,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                                width: 0.5)),
                                        filled: true,
                                        // Enable filled mode
                                        fillColor: Colors.grey[200],
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.darkPurple),
                                          // Customize focused border color
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.red),
                                          // Customize error border color
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: AppColors.secondaryText,
                                            letterSpacing: 0.7),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 20.0),
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.envelope,
                                          color: AppColors.darkPurple,
                                          size: 18.0,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 270),
                                  child: TextFormField(
                                      controller: _phoneNumberController,
                                      readOnly: true,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: _phoneNumberController.text,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                                width: 0.5)),
                                        filled: true,
                                        // Enable filled mode
                                        fillColor: Colors.grey[200],
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.darkPurple),
                                          // Customize focused border color
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColors.red),
                                          // Customize error border color
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: AppColors.secondaryText,
                                            letterSpacing: 0.7),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 20.0),
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.mobileScreen,
                                          color: AppColors.darkPurple,
                                          size: 18.0,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:
                                  FadeInUp(
                                    duration: Duration(milliseconds: 280),
                                    child: Text(
                                      'Cannot edit. You are required to use your PetroApp registered number only',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryText),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FadeInUp(
                                      duration: Duration(milliseconds: 300),
                                  child: TextFormField(
                                      controller: _addressController,
                                      textCapitalization:
                                      TextCapitalization.characters,
                                      maxLines: 3,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Address is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Address',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  color: AppColors.lightPurple,
                                                  width: 0.5)),
                                          filled: true,
                                          // Enable filled mode
                                          fillColor: Colors.grey[200],
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.darkPurple),
                                            // Customize focused border color
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: AppColors.red),
                                            // Customize error border color
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          hintStyle: const TextStyle(
                                              color: AppColors.secondaryText,
                                              letterSpacing: 0.7),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 20.0),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(bottom: 35.0),
                                            child: Icon(
                                              FontAwesomeIcons.house,
                                              color: AppColors.darkPurple,
                                              size: 18.0,
                                            ),
                                          ))),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 320),
                                  child: TextFormField(
                                    controller: _dobController,
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Dob required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'DOB',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                              color: AppColors.lightPurple,
                                              width: 0.5)),
                                      filled: true,
                                      // Enable filled mode
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.darkPurple),
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
                                        FontAwesomeIcons.calendar,
                                        color: AppColors.darkPurple,
                                        size: 18.0,
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.calendarCheck,
                                        color: AppColors.secondaryText,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 325),child: Text("Gender")),
                                Row(
                                  children: [

                                    FadeInUp(
                                      duration: Duration(milliseconds: 330),
                                      child: Radio(
                                        value: 'Male',
                                        activeColor: AppColors.darkPurple,
                                        groupValue: _selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 335),
                                        child: Text('Male')),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 340),child:Radio(
                                      value: 'Female',
                                      groupValue: _selectedGender,
                                      activeColor: AppColors.darkPurple,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                    ),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 345),
                                        child: Text('Female')),

                                    FadeInUp(
                                      duration: Duration(milliseconds: 350),
                                      child: Radio(
                                        value: 'Helicopter',
                                        activeColor: AppColors.darkPurple,
                                        groupValue: _selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 355),
                                        child: Text('Others')),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 375),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: imageUploaded
                                        ? [
                                            Text('Uploaded Successfully'),
                                            Icon(
                                              Icons.check_circle_outline_sharp,
                                              color: AppColors.green,
                                            )
                                          ]
                                        : [
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
                                                _getImage();
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 70,
                                                padding: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.darkPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(28.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Upload',
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 395),
                                  child: InkWell(
                                    onTap: ()async {
                                      if (_image != null && _validateForm()) {
                                        if (_isAgeValid(_selectedDate!)) {
                                          await uploadImageMedia(_image!);
                                          FocusScope.of(context).unfocus();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('You must be at least 18 years old.'),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Please fill all fields.'),
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                      FocusScope.of(context).unfocus();
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
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ]),
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
            ),
    );
  }
}

class RequestTextfield extends StatelessWidget {
  const RequestTextfield({
    super.key,
    required this.Controller,
    required this.prefixicon,
    required this.validatorValue,
    required this.errorMsg,
    this.onTap,
    this.issufixIcon = false,
    this.address = false,
    this.readOnly = false,
    this.convertToUpperCase = false,
    required this.hintText,
  });

  final TextEditingController Controller;
  final IconData prefixicon;
  final Function(String value) validatorValue;
  final bool address;
  final String errorMsg;
  final Function()? onTap;
  final bool issufixIcon;
  final bool convertToUpperCase;
  final bool readOnly;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      textCapitalization: convertToUpperCase
          ? TextCapitalization.characters
          : TextCapitalization.none,
      onTap: onTap,
      maxLines: address ? 3 : 1,
      readOnly: readOnly,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return validatorValue(value);
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: AppColors.lightPurple, width: 0.5)),
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
          prefixIcon: address
              ? Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: Icon(
                    prefixicon,
                    color: AppColors.darkPurple,
                    size: 18.0,
                  ),
                )
              : Icon(
                  prefixicon,
                  color: AppColors.darkPurple,
                  size: 18.0,
                ),
          suffixIcon: issufixIcon
              ? Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: AppColors.secondaryText,
                )
              : null),
    );
  }
}
