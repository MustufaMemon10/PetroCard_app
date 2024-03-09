import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
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
  File? _panPhotoPath;
  DateTime? _selectedDate;
  bool _isLoading = false;
  bool isLoading = false;
  var logindata;
  var data;
  String id = '';
  String email = '';
  String name = '';
  String phone = '';

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

  Future<void> _handleApplication() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url =
          Uri.parse("https://petrocard.000webhostapp.com/API/apply_card.php");
      final response = await http.post(login_url, body: {
        "id": id,
        "doc_img": _panPhotoPath,
        "address": _addressController.text,
        "gender": _selectedGender,
        "dob": _dobController.text,
        "pan_number": panNumberController.text,
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
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ConfirmationAnimation()),
              (route) => false);
        } else {
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
  uploadImageMedia(File fileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("https://petrocard.000webhostapp.com/API/apply_card.php"));

    final file = await http.MultipartFile.fromPath('doc_img', fileImage.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

    imageUploadRequest.fields['id']= id;
    imageUploadRequest.fields['address']= _addressController.text;
    imageUploadRequest.fields['dob']= _dobController.text;
    imageUploadRequest.fields['gender']= _selectedGender;
    imageUploadRequest.fields['pan_number']= panNumberController.text;
    imageUploadRequest.files.add(file);
    try {
      _isLoading = true;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        if(streamedResponse.statusCode==200){
          logindata = jsonDecode(value);
          data = jsonDecode(value)['user'];
          print(logindata);
          setState(() {
            isLoading = false;
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
                MaterialPageRoute(builder: (context) => ConfirmationAnimation()),
                    (route) => false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logindata['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red, // Customize background color
              ),
            );
          }
          print(streamedResponse.stream);
          print(value);
        }else{
          setState(() {
            _isLoading=false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          print(value);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _handleApplication() async {
  //   final form = _formKey.currentState;
  //   if (form!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final login_url =
  //         Uri.parse("https://petrocard.000webhostapp.com/API/apply_card.php");
  //     try {
  //       final response = await http.post(login_url, body: {
  //         "doc_img": _panPhotoPath,
  //         "address": _addressController.text,
  //         "gender": _selectedGender,
  //         "dob": _dobController.text,
  //         "pan_number": panNumberController.text,
  //         "id": id,
  //       });
  //       if (response.statusCode == 200) {
  //         final decodedResponse = jsonDecode(response.body);
  //         if (decodedResponse['error'] == false) {
  //           final data = decodedResponse['user'];
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(decodedResponse['message'].toString()),
  //               duration: Duration(seconds: 2),
  //               backgroundColor: Colors.green,
  //             ),
  //           );
  //           Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(builder: (context) => ConfirmationAnimation()),
  //             (route) => false,
  //           );
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(decodedResponse['message'].toString()),
  //               duration: Duration(seconds: 2),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         }
  //       } else {
  //         print('HTTP request failed with status: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Error occurred during HTTP request: $e');
  //     } finally {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
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
      });
    }
  }

  //
  // bool _isAgeValid(DateTime dob) {
  //   DateTime now = DateTime.now();
  //   int age = now.year - dob.year;
  //   if (now.month < dob.month ||
  //       (now.month == dob.month && now.day < dob.day)) {
  //     age--;
  //   }
  //   return age >= 18;
  // }

  Future<void> _pickPhoto() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(
        source:
            _panPhotoPath != null ? ImageSource.gallery : ImageSource.camera,
      );
      if (pickedFile != null) {
        setState(() {
          _panPhotoPath = File(pickedFile.path);
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

  // bool _validateForm() {
  //   if (_selectedGender.isEmpty || _panPhotoPath == null ||
  //       _panPhotoPath!.isEmpty ) {
  //     return false;
  //   }
  //   if (_formKey.currentState!.validate()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.darkPurple,
                rightDotColor: AppColors.secondaryText,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 0.10.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){ Navigator.pop(context);},
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(width:1.0,color: AppColors.darkPurple)
                          ),
                          child: Icon(Icons.arrow_back,color: AppColors.darkPurple),
                        ),
                      )
                    ],
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
                            Text(
                              "Elevate your Payment experience",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "with our feature-rich Petro Card.",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0,
                                color: AppColors.darkPurple,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
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
                                    FontAwesomeIcons.creditCard,
                                    color: AppColors.darkPurple,
                                    size: 18.0,
                                  ),
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: _emailController,
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
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: _phoneNumberController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone Number is required';
                                  }

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
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: _addressController,
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
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
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
                                  activeColor: AppColors.darkPurple,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Female'),
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
                                Text('Helicopter'),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Upi Id required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintStyle: const TextStyle(
                                        color: AppColors.secondaryText,
                                        letterSpacing: 0.7),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
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
                                    labelText: 'Enter UPI Id',
                                    floatingLabelStyle:
                                        TextStyle(color: AppColors.darkPurple),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    uploadImageMedia(_panPhotoPath!);
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
                                        borderRadius:
                                            BorderRadius.circular(50.r),
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
              ]),
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
